# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

yml = File.read("#{Rails.root}/db/seeds/songs.yml")
songs = YAML.load(yml)

songs.each do |s|
  Song.create( :poet => s['poet'],  :poem => s['poem'] ,  :first_half => s['first_half'] ,  :second_half => s['second_half'] )
end
