class HistoriesController < ApplicationController

  def show
    @history = History.new

    #次にやる問題を、最後にやった歌の次から1日3件で取得する
    last_song = History.who(current_user).original.order("created_at DESC").first
    last_song_id = (last_song) ? last_song.song_id : 0
    done_today = History.who(current_user).which_day(Date.today).original.count
    songs_left = [(SONGS_PER_DAY - done_today), 0].max
    @songs = Song.order("id ASC").offset(last_song_id).limit(songs_left)

    #すでに３問やってたら終了ページにリダイレクト
    redirect_to :root and return if songs_left == 0

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def save
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
