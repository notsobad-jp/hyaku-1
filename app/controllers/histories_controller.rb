class HistoriesController < ApplicationController
  skip_before_filter :require_login, :only => :index
  SONGS_PER_DAY = 3  #１日におぼえる歌の数

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @histories }
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    @history = History.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/new
  # GET /histories/new.json
  def new
    @history = History.new

    #次にやる問題を、最後にやった歌の次から1日3件で取得する
    last_song = History.who(current_user).original.order("created_at DESC").first
    last_song_id = (last_song) ? last_song.song_id : 0
    done_today = History.who(current_user).which_day(Date.today).original.count
    songs_left = SONGS_PER_DAY - done_today
    @songs = Song.order("id ASC").offset(last_song_id).limit(songs_left)

    #すでに３問やってたら終了ページにリダイレクト
    redirect_to histories_url and return if songs_left == 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/1/edit
  def edit
    @history = History.find(params[:id])

  end

  # POST /histories
  # POST /histories.json
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

  # PUT /histories/1
  # PUT /histories/1.json
  def update
    @history = History.find(params[:id])

    respond_to do |format|
      if @history.update_attributes(params[:history])
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history = History.find(params[:id])
    @history.destroy

    respond_to do |format|
      format.html { redirect_to histories_url }
      format.json { head :no_content }
    end
  end
end
