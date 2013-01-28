class RemoveFirstHalfAndSecondHalfFromSongs < ActiveRecord::Migration
  def up
    remove_column :songs, :first_half
    remove_column :songs, :second_half
  end

  def down
    add_column :songs, :second_half, :integer
    add_column :songs, :first_half, :integer
  end
end
