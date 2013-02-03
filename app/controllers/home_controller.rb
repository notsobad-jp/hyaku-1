class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    if current_user
      @learn_num_left = History.learn_num_left(current_user)   #Learn: 今日の歌を取得
      @review_num = History.review_num(current_user)           #Review: 今日の復習対象を取得
      @review_num_finished = History.review_num_finished(current_user)  #Review: 今日の残り復習数を取得
      @score = History.who(current_user).where(:exam_id => 1).where(:result => 1).count  #Exam: 前回のスコア取得
    else
      redirect_to :top
    end
  end

  def top
  end

  def about
  end

  def credit
  end
end
