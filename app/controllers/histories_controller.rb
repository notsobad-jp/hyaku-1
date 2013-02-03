class HistoriesController < ApplicationController

  def show
    @history = History.new

    #次にやる問題を取得。三問終わってたらホームにリダイレクト。
    @next_song = History.next_song(current_user)
    redirect_to :learn_finish and return if @next_song.nil?

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def save
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        #次にやる問題を取得。
        @next_song = History.next_song(current_user)

        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.js
        format.json { render json: @history, status: :created, location: @history }
      else
        format.html { render action: "new" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish
    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end
end
