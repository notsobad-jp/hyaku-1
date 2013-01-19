class DestroyUsers < ActiveRecord::Migration
  def up
  end

  def down
    drop_table :users
  end
end
