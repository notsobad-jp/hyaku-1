class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :poet
      t.string :poem
      t.string :first_half
      t.string :second_half
      t.timestamps
    end
  end
end
