class History < ActiveRecord::Base
  attr_accessible :result, :song_id, :exam_flg, :user_id
  belongs_to :user
  belongs_to :song

  scope :who, lambda { |user| where(:user_id => user.id) }
  scope :which_day, lambda { |t| where(:created_at => t.beginning_of_day..t.end_of_day) }
  scope :original, where("result IS ?", nil)
end
