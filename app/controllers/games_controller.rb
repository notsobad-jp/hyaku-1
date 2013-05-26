# coding: utf-8
class GamesController < ApplicationController
  def index
    @title = "5分で簡単!ミニテスト"
    @user = current_user || User.find(0)

    #セッション初期化
    session[:exam_song_id] = (rand(8)+1) * (-1) #初期値は -1 ~ -9 に設定。
    session[:exam_score] = 0

    #いまのステータス初期値
    @finished_num = 0
    @current_score = 0
  end

  def show
    @title = "5分で簡単!ミニテスト"
    @user = current_user || User.find(0)

    #つぎの問題を取得
    session[:exam_song_id] += 10
    @exam_song = (session[:exam_song_id] <= 100) ? Song.find(session[:exam_song_id]) : nil

    #いまのステータス取得（何問中何問正解か）
    @finished_num = session[:exam_song_id] - 1
    @current_score = session[:exam_score]

    redirect_to :games_finish and return if @exam_song.nil?
    @exam_targets = Song.set_question(@exam_song.id)

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])
    @result = @history.result
    session[:exam_score] += 1 if @result==1
    render :nothing => true and return if History.answered?(@history)

    respond_to do |format|
        format.js
    end
  end

  def finish
    @title = "5分で簡単!ミニテスト"
    @score = session[:exam_score]
    @user = current_user || User.find(0)

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
