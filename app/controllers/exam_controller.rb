class ExamController < ApplicationController

  def index
    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).where(:exam_id > 0).order("exam_id DESC").first
    @exam_id = (last_exam.present?) ? last_exam.exam_id+1 : 1
    @exam_song = Song.random(1).first
    @exam_targets = Song.set_question(@exam_song.id)

    render :action => "show"
  end

  def show
    @history = History.new

    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).where(:exam_id > 0).order("exam_id DESC").first
    @exam_id = (last_exam) ? last_exam.exam_id : 1

    #まだやってない問題を取得。全部おわってれば結果画面にリダイレクト。
    @exam_song = History.exam_song(current_user, @exam_id)
    @exam_targets = Song.set_question(@exam_song.id) if @exam_song.present?
    redirect_to :exam_finish and return if @exam_song.nil?

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
    last_exam = History.who(current_user).order("exam_id DESC").first
    @exam_id = (last_exam) ? last_exam.exam_id : 1
    @score = History.where(:exam_id => @exam_id).who(current_user).where(:result => 1).count

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
