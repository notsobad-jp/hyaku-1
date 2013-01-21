class History < ActiveRecord::Base
  attr_accessible :result, :song_id, :exam_flg, :user_id
  belongs_to :user
  belongs_to :song
end
