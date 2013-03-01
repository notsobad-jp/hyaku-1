# coding: utf-8
class HistoriesController < ApplicationController
  def show
    @title = "[守]あたらしい歌を覚える"
    @history = History.new

    #次にやる問題を取得。三問終わってたらホームにリダイレクト。
    @user = current_user || User.find(0)
    if current_user
      @next_song = History.next_song(@user)
    else
      session[:learn_song_id] ||= 1
      @next_song = (session[:learn_song_id] <= 3) ? Song.find(session[:learn_song_id]) : nil
    end
    redirect_to :learn_finish and return if @next_song.nil?

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def save
    @user = current_user || User.find(0)
    @history = History.new(params[:history])
    redirect_to :learn and return if History.answered?(@history)

    if current_user
      @history.save
      @next_song = History.next_song(current_user)  #次にやる問題を取得。
    else
      session[:learn_song_id] += 1
      @next_song = (session[:learn_song_id] <= 3) ? Song.find(session[:learn_song_id]) : nil
    end

    respond_to do |format|
      format.js
    end
  end

  def finish
    @title = "[守]あたらしい歌を覚える"
    @user = current_user || User.find(0)
    if current_user
      @finished_songs = History.who(current_user).original.which_day(Date.today).order("created_at DESC")
    else
      session[:learn_song_id] = 1
      @finished_songs = Song.where(["id IN (?)", 1..3])
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @history }
    end
  end
end
