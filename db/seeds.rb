# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Songsテーブル作成
yml = File.read("#{Rails.root}/db/seeds/songs.yml")
songs = YAML.load(yml)

songs.each do |s|
  Song.create( :poet => s['poet'],  :poem => s['poem'], :kana => s['kana'], :comment => s['comment'])
end

# Authorテーブル作成
yml = File.read("#{Rails.root}/db/seeds/authors.yml")
authors = YAML.load(yml)

authors.each do |a|
  Author.create( :name => a['name'],  :period => a['period'], :info => a['info'])
end
