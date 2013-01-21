class ExamController < ApplicationController
  def index
  end

  def new
    @history = History.new
    @all_songs = Song.find(:all, :order => 'RAND()')

    respond_to do |format|
      format.html # try.html.erb
      format.json { render json: @history }
    end
  end

  def create
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.js
        format.json { render json: @history, status: :created, location: @history }
      else
        format.html { render action: "new" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end
end
