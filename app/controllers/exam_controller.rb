# coding: utf-8
class ExamController < ApplicationController
  def index
    @title = "[離]百首まとめてテストする"
    @user = current_user || User.find(0)
    #examID(何回目のテストか)を取得
    if current_user
      last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
      @exam_id = (last_exam.present?) ? last_exam.exam_id+1 : 1
      @exam_song = Song.random(1).first
    else
      session[:exam_song_id] = 1
      session[:exam_score] = 0
      @exam_song = Song.find(1)
    end
    @exam_targets = Song.set_question(@exam_song.id)

    #いまのステータス初期値
    @finished_num = 0
    @current_score = 0

    render :action => "show"
  end

  def show
    @title = "[離]百首まとめてテストする"
    @user = current_user || User.find(0)
    @history = History.new

    if current_user
      #つぎの問題を取得
      last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
      @exam_id = (last_exam) ? last_exam.exam_id : 1
      @exam_song = History.exam_song(current_user, @exam_id)

      #いまのステータス取得（何問中何問正解か）
      @finished_num = History.who(current_user).where("exam_id = ?", @exam_id).count
      @current_score = History.who(current_user).where("exam_id = ?", @exam_id).where(:result => 1).count
    else
      #つぎの問題を取得
      session[:exam_song_id] += 1
      @exam_song = (session[:exam_song_id] <= 100) ? Song.find(session[:exam_song_id]) : nil

      #いまのステータス取得（何問中何問正解か）
      @finished_num = session[:exam_song_id] - 1
      @current_score = session[:exam_score]
    end
    redirect_to :exam_finish and return if @exam_song.nil?
    @exam_targets = Song.set_question(@exam_song.id)

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])
    @result = @history.result
    session[:exam_score] += 1 if @result==1 && current_user.blank?
    render :nothing => true and return if History.answered?(@history)
    @history.save if current_user

    respond_to do |format|
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.js
        format.json { render json: @history, status: :created, location: @history }
    end
  end

  def finish
    @title = "[離]テスト結果"
    if current_user
      #examID(何回目のテストか)を取得
      last_exam = History.who(current_user).where("exam_id > 0").order("exam_id DESC").first
      redirect_to :root and return if last_exam.nil?
      @exam_id = last_exam.exam_id
      @score = History.where(:exam_id => @exam_id).who(current_user).where(:result => 1).count
    else
      @score = session[:exam_score]
    end

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
