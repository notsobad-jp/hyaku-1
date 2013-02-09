class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :period
      t.text :info

      t.timestamps
    end
  end
end
