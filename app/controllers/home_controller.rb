class HomeController < ApplicationController
  def index
    @songs = Song.all
  end

  def training
    #まだやってない3件を取得
    last_song = rand(5)
    @new_song = Song.order("id ASC").offset(last_song).first
  end
end
