class RemoveResult7AndResult3FromHistory < ActiveRecord::Migration
  def up
    remove_column :histories, :result_7
    remove_column :histories, :result_3
  end

  def down
    add_column :histories, :result_3, :integer
    add_column :histories, :result_7, :integer
  end
end
