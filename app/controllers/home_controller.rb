class HomeController < ApplicationController
  def index
    @songs = Song.all
  end

  def training
    #$B$^$@$d$C$F$J$$(B3$B7o$r<hF@(B
    last_song = rand(5)
    @new_song = Song.order("id ASC").offset(last_song).first
  end
end
