class SongsController < ApplicationController
  def index
    @user = current_user || User.find(0)
    @songs = Song.includes(:author).all
    @finished_songs = History.finished_songs(@user)
  end

  def show
    @song = Song.find(params[:id])
  end
end
