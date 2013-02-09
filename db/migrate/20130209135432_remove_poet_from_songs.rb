class RemovePoetFromSongs < ActiveRecord::Migration
  def up
    remove_column :songs, :poet
  end

  def down
    add_column :songs, :poet, :string
  end
end
