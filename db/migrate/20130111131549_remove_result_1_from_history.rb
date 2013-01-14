class RemoveResult1FromHistory < ActiveRecord::Migration
  def up
    remove_column :histories, :result_1
  end

  def down
    add_column :histories, :result_1, :integer
  end
end
