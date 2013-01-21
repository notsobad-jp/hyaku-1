class Song < ActiveRecord::Base
  attr_accessible :poet, :poem, :first_half, :second_half

  has_many :histories
end
