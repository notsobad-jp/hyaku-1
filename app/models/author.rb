class Author < ActiveRecord::Base
  attr_accessible :info, :name, :period
  belongs_to :songs
  has_many :histories, :through => :song
end
