class Song < ActiveRecord::Base
  attr_accessible :poet, :poem, :kana, :comment
  has_many :histories
  has_one :authors

  random = (Rails.env.production?) ? 'RANDOM()' : 'RAND()'
  scope :random, lambda { |limit| find(:all, :order => random, :limit => limit) }

  #テスト用にダミーの歌と混ぜた状態で返す
  def self.set_question(song_id)
    dummys = self.where("id <> ?", song_id).random(4)
    genuine = self.where("id = ?", song_id)
    question = (genuine + dummys).sort_by{rand}
    return question
  end
end
