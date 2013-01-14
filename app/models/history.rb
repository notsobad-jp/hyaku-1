class History < ActiveRecord::Base
  attr_accessible :result, :song_id, :times, :user_id
end
