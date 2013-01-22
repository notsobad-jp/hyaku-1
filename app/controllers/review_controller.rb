class ReviewController < ApplicationController
  def show
    @history = History.new

    # 復習対象の問題を取得（1,3,7日前）
    [1,3,7].each do |d|
      instance_variable_set("@review_targets_#{d}", History.original.which_day(d.day.ago).who(current_user).includes(:song) )
    end
    @review_targets = @review_targets_1 + @review_targets_3 + @review_targets_7

    #復習対象がなかったらホーム画面にリダイレクト
    redirect_to :root and return if @review_targets.blank?

    respond_to do |format|
      format.html
      format.json { render json: @history }
    end
  end

  def answer
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
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
