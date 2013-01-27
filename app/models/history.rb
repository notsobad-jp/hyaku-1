class History < ActiveRecord::Base
  attr_accessible :result, :song_id, :exam_flg, :user_id
  belongs_to :user
  belongs_to :song

  scope :who, lambda { |user| where(:user_id => user.id) }
  scope :which_day, lambda { |t| where(:created_at => t.beginning_of_day..t.end_of_day) }
  scope :original, where("result IS ?", nil)

  SONGS_PER_DAY = 3

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
end
