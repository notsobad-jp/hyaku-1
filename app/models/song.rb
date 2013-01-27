class Song < ActiveRecord::Base
  attr_accessible :poet, :poem, :first_half, :second_half
  has_many :histories

  random = (Rails.env.production?) ? 'RANDOM()' : 'RAND()'
  scope :random, lambda { |limit| find(:all, :order => random, :limit => limit) }

  #テスト用にダミーの歌と混ぜた状態で返す
  def self.set_question(target_song)
    dummys = self.where("id <> ?", target_song.song_id).random(4)
    genuine = self.where("id = ?", target_song.song_id)
    question = (genuine + dummys).sort_by{rand}
    return question
  end
end
