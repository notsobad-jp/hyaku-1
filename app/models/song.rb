class Song < ActiveRecord::Base
  attr_accessible :poet, :poem, :first_half, :second_half
  has_many :histories

  rand = (Rails.env.production?) ? 'RANDOM()' : 'RAND()'
  scope :rand, lambda { |limit| find(:all, :order => rand, :limit => limit) }
end
