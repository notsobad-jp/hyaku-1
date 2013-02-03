class ExamController < ApplicationController

  def show
    @history = History.new

    #examID(何回目のテストか)を取得
    last_exam = History.who(current_user).order("exam_id DESC").first
    @exam_id = (last_exam) ? last_exam.exam_id + 1 : 1

    #最初の問題を取得
    @exam_song = Song.random(1).first
    @exam_targets = Song.set_question(@exam_song.id)

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])

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

  def score
    @score = History.where(:exam_id => 1).who(current_user).where(:result => 1).count

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
