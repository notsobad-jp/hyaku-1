class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    #Learn: 今日の歌を取得
    last_song = History.who(current_user).where("created_at < ?", Date.today).original.order("created_at DESC").first
    last_song_id = (last_song) ? last_song.song_id : 0
    @songs = Song.order("id ASC").offset(last_song_id).limit(SONGS_PER_DAY).includes(:histories)

    #Review: 今日の復習対象を取得
    [1,3,7].each do |d|
      instance_variable_set("@review_targets_#{d}", History.original.which_day(d.day.ago).who(current_user).includes(:song) )
    end

    #Exam: 前回のスコア取得
    @score = History.who(current_user).where(:exam_flg => 1).where(:result => 1).count

  end
end
