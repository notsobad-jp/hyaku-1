class ExamController < ApplicationController

  def index
    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
    @exam_id = (last_exam.present?) ? last_exam.exam_id+1 : 1
    @exam_song = Song.random(1).first
    @exam_targets = Song.set_question(@exam_song.id)

    #いまのステータス初期値
    @finished_num = 0
    @current_score = 0

    render :action => "show"
  end

  def show
    @history = History.new

    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
    @exam_id = (last_exam) ? last_exam.exam_id : 1

    #まだやってない問題を取得。全部おわってれば結果画面にリダイレクト。
    @exam_song = History.exam_song(current_user, @exam_id)
    @exam_targets = Song.set_question(@exam_song.id) if @exam_song.present?
    redirect_to :exam_finish and return if @exam_song.nil?

    #いまのステータス取得（何問中何問正解か）
    @finished_num = History.who(current_user).where("exam_id = ?", @exam_id).count
    @current_score = History.who(current_user).where("exam_id = ?", @exam_id).where(:result => 1).count

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])
    render :nothing => true and return if History.answered?(@history)

    respond_to do |format|
      if @history.save
        @exam_id = @history.exam_id
        @exam_song = History.exam_song(current_user, @exam_id)
        @exam_targets = Song.set_question(@exam_song.id) if @exam_song.present?
        @result = @history.result
        @finished_num = History.who(current_user).where("exam_id = ?", @exam_id).count
        @current_score = History.who(current_user).where("exam_id = ?", @exam_id).where(:result => 1).count

        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.js
        format.json { render json: @history, status: :created, location: @history }
      else
        format.html { render action: "show" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish
    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
    redirect_to :root and return if last_exam.nil?
    @exam_id = last_exam.exam_id
    @score = History.where(:exam_id => @exam_id).who(current_user).where(:result => 1).count

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
