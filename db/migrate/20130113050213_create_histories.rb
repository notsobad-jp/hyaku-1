class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :song_id
      t.integer :times
      t.integer :result

      t.timestamps
    end
  end
end
