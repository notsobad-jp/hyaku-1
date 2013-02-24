class SongsController < ApplicationController
  def index
    @songs = Song.includes(:author).all
  end

  def show
    @song = Song.find(params[:id])
  end
end
