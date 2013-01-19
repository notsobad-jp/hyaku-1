class Histories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :song_id
      t.integer :result
      t.integer :exam_flg
      t.timestamps
    end
  end
end
