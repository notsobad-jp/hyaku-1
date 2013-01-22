class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  SONGS_PER_DAY = 3  #１日におぼえる歌の数
end
