class AddColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :poet, :string
    add_column :songs, :poem, :text
  end
end
