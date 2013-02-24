# coding: utf-8
class SongsController < ApplicationController
  def index
    @title = "百人一首の一覧"
    @user = current_user || User.find(0)
    @songs = Song.includes(:author).all
    @finished_songs = History.finished_songs(@user)
  end

  def show
    @title = "百人一首 歌の詳細"
    @song = Song.find(params[:id])
  end
end
