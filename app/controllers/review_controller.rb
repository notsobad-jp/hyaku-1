class ReviewController < ApplicationController
  def show
    @history = History.new

    #復習対象の歌を１つ取得。全部おわってればリダイレクト。
    @review_song = History.review_song(current_user)
    redirect_to :root and return if @review_song.nil?

    #ダミーの歌と混ぜた状態で取得。
    @review_targets = Song.set_question(@review_song.song_id)

    #今日やる問題数・終了した問題数を取得
    @review_num = History.review_num(current_user)
    @review_num_finished = History.review_num_finished(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        #復習対象の歌を１つ取得。全部おわってればリダイレクト。
        @review_song = History.review_song(current_user)
        @review_targets = Song.set_question(@review_song.song_id) if @review_song.present?
        @review_num = History.review_num(current_user)
        @review_num_finished = History.review_num_finished(current_user)
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
end
