class History < ActiveRecord::Base
  attr_accessible :result, :song_id, :exam_id, :user_id
  belongs_to :user
  belongs_to :song

  scope :who, lambda { |user| where(:user_id => user.id) }
  scope :which_day, lambda { |t| where(:created_at => t.beginning_of_day..t.end_of_day) }
  scope :original, where("result IS ?", nil)

  SONGS_PER_DAY = 3

  #結果の再送信を制御。もう答え済みならfalseを返す。
  def self.answered?(record)
    past_answer = self.where(:user_id => record.user_id).where(:exam_id => record.exam_id).where(:song_id => record.song_id).which_day(Date.today)
    return (past_answer.count > 0) ? true : false
  end

  #次の問題を取得。3問おわってればnilを返す。
  def self.next_song(user)
    last_song = self.who(user).original.order("created_at DESC").first
    last_song_id = (last_song) ? last_song.song_id : 0
    next_song = Song.order("id ASC").offset(last_song_id).first

    done_today = self.who(user).which_day(Date.today).original.count
    songs_left = [(SONGS_PER_DAY - done_today), 0].max
    return (songs_left > 0) ? next_song : nil
  end

  #今日の残り問題数
  def self.learn_num_left(user)
    done_today = self.who(user).which_day(Date.today).original.count
    learn_num_left = [(SONGS_PER_DAY - done_today), 0].max
  end

  #今日の復習対象問題数
  def self.review_num(user)
    review_num = 0
    [1,3,7].each do |d|
      targets = self.original.which_day(d.day.ago).who(user)
      review_num += targets.count
    end
    return review_num
  end

  #今日の復習済み問題数
  def self.review_num_finished(user)
    target = self.which_day(Date.today).who(user).where(:exam_id => 0).where("result IS NOT ?", nil)
    return (target.present?) ? target.count : 0
  end


  #復習対象の問題をランダムで１つ返す。
  def self.review_song(user)
    #今日すでにやった問題のID一覧を取得
    finished_ids = Array.new
    finished_songs = self.select(:song_id).who(user).which_day(Date.today).where("result IS NOT ?", nil)
    finished_songs.each do |f|
      finished_ids << f.song_id if f.present?
    end

    #やってない復習対象のレコードを全取得
    targets = Array.new
    [1,3,7].each do |d|
      target = self.original.which_day(d.day.ago).who(user)
      target = target.where(["song_id NOT IN (?)", finished_ids]) if finished_ids.present?
      targets = targets + target.includes(:song) if target.present?
    end
    return targets.sort_by{rand}.first.presence || nil
  end

  #テストの問題をランダムで１つ返す。
  def self.exam_song(user, exam_id)
    #すでにやった問題のID一覧を取得
    finished_ids = Array.new
    finished_songs = self.select(:song_id).who(user).where(:exam_id => exam_id)
    finished_songs.each do |f|
      finished_ids << f.song_id if f.present?
    end

    #やってない問題からランダムで１つ選択
    target = Song.where(["id NOT IN (?)", finished_ids]).sort_by{rand}.first if finished_ids.present?
    return target.presence || nil
  end
end
