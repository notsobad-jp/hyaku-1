class ReviewController < ApplicationController
  def index
    #Review:1day
    @review_targets_1 = History.where(:created_at => Date.yesterday.beginning_of_day..Date.yesterday.end_of_day).includes(:song)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end

  def new
    @history = History.new

    #Review:1day
    @review_targets_1 = History.where(:created_at => Date.yesterday.beginning_of_day..Date.yesterday.end_of_day).includes(:song)
    @dummy_songs = Song.find(:all, :order => 'RAND()', :limit => 3)

    respond_to do |format|
      format.html # try.html.erb
      format.js
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
