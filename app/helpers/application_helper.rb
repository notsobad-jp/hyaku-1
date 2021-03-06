# coding: utf-8
module ApplicationHelper
  def title
    base_title = "百/一"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def canonical_link
    link = "http://hyaku-1.eure-ka.me"
    if params[:controller] == "histories"
      link = "http://hyaku-1.eure-ka.me/learn"
    elsif params[:controller] == "review"
      link = "http://hyaku-1.eure-ka.me/review"
    elsif params[:controller] == "exam"
      link = "http://hyaku-1.eure-ka.me/exam"
    elsif params[:controller] == "songs"
      link = "http://hyaku-1.eure-ka.me/songs"
    end
    return link
  end

  def last_song_id
    if current_user
      last_song = History.who(current_user).original.order("created_at DESC").first
      last_song_id = (last_song) ? last_song.song_id.to_i : 0
    else
      last_song_id = 0
    end
    return last_song_id
  end

  def days_left(last_song_id)
    days_left = ( (100-last_song_id)/3 ).ceil
  end

  def best_score
    if current_user
      score = History.who(current_user).group(:exam_id).where(:result => 1).where("exam_id > 0").count.max{|a,b| a[1] <=> b[1]}
      best_score = (score) ? score[1] : 0
    else
      best_score = 0
    end
    return best_score
  end

  def profile_image
    if current_user
      profile_image = image_tag("https://graph.facebook.com/#{Authentication.find(current_user.id).uid}/picture?type=normal", :alt => 'profile_image')
    else
      profile_image = image_tag("poet/guest.jpg", :alt => 'profile_image')
    end
    return profile_image
  end


  def degree(score)
    case score
      when 0
        degree = "初心者"
      when 1..9
        degree = "駆け出し歌人"
      when 10..19
        degree = "そこそこ歌人"
      when 20..29
        degree = "伸び盛り歌人"
      when 30..39
        degree = "一人前歌人"
      when 40..49
        degree = "中堅歌人"
      when 50..59
        degree = "二流歌人"
      when 60..69
        degree = "一流歌人"
      when 70..79
        degree = "天才歌人"
      when 80..89
        degree = "歌人殿堂入り"
      when 90..99
        degree = "歌仙"
      when 100
        degree = "歌聖"
    end
    return degree
  end
end
