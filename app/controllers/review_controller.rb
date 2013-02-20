class ReviewController < ApplicationController

  def index
    if current_user
      @review_songs = History.review_song_all(current_user)
      @review_num = History.review_num(current_user)
      @review_num_finished = History.review_num_finished(current_user)
      redirect_to :review_finish and return if (@review_num == @review_num_finished) && @review_num != 0
    end
    session[:review_song_id] = 1 unless current_user

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @history = History.new

    #復習対象の歌を１つ取得。全部おわってればリダイレクト。
    @user = current_user || User.find(0)
    if current_user
      @review_song = History.review_song(current_user)
    else
      session[:review_song_id] ||= 1
      @review_song = (session[:review_song_id] <= 3) ? Song.find(session[:review_song_id]) : nil
    end
    redirect_to :review_finish and return if @review_song.nil?

    #ダミーの歌と混ぜた状態で取得。
    @review_targets = Song.set_question(@review_song.id)

    #今日やる問題数・終了した問題数を取得
    if current_user
      @review_num = History.review_num(current_user)
      @review_num_finished = History.review_num_finished(current_user)
    else
      @review_num = 3
      @review_num_finished = session[:review_song_id]-1
    end

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @user = current_user || User.find(0)
    @history = History.new(params[:history])
    @result = @history.result
    render :nothing => true and return if History.answered?(@history)

    if current_user
      @history.save
    else
      session[:review_song_id] += 1
    end

    respond_to do |format|
      format.html { redirect_to @history, notice: 'History was successfully created.' }
      format.js
    end
  end

  def finish
    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
