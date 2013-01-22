class ExamController < ApplicationController
  def show
    @history = History.new
    @all_songs = Song.find(:all, :order => 'RAND()')

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
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
    @score = History.where(:exam_flg => 1).who(current_user).where(:result => 1).count

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
