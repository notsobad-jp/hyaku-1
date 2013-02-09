class AddKanaAndCommentToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :kana, :string
    add_column :songs, :comment, :string
  end
end
