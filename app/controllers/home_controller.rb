class HomeController < ApplicationController

  def index
    #今日の歌を取得
    last_song = History.who(current_user).where("created_at < ?", Date.today).original.order("created_at DESC").first
    last_song_id = (last_song) ? last_song.song_id : 0
    @songs = Song.order("id ASC").offset(last_song_id).limit(SONGS_PER_DAY).includes(:histories)
  end
end
