# coding: utf-8
class SongsController < ApplicationController
  def index
    @title = "百人一首の一覧"
    @user = current_user || User.find(0)
    @songs = Song.includes(:author).order("id ASC").all
  end

  def show
    @title = "百人一首の意訳・意味"
    @song = Song.find(params[:id])
  end
end
