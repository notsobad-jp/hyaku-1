class Author < ActiveRecord::Base
  attr_accessible :info, :name, :period
  belongs_to :songs
end
