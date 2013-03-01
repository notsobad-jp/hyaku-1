# coding: utf-8
class HomeController < ApplicationController
  def index
    @title = "百人一首を1ヶ月くらいで覚えるサービス"
    @user = current_user || User.find(0)  #ログインしてなかったらID=0のダミーユーザー
    @learn_num_left = History.learn_num_left(@user)   #Learn: 今日の歌を取得
    @review_num = History.review_num(@user)           #Review: 今日の復習対象を取得
    @review_num_finished = History.review_num_finished(@user)  #Review: 今日の残り復習数を取得
    @score = History.who(@user).where(:exam_id => 1).where(:result => 1).count  #Exam: 前回のスコア取得
  end

  def top
    @title = "百人一首を1ヶ月くらいで覚えるサービス"
    redirect_to :root if current_user
  end

  def about
    @title = "このサイトについて"
  end

  def credit
  end
end
