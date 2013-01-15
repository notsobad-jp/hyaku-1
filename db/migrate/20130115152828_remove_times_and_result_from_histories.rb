class RemoveTimesAndResultFromHistories < ActiveRecord::Migration
  def up
    remove_column :histories, :times
    remove_column :histories, :result
  end

  def down
    add_column :histories, :result, :integer
    add_column :histories, :times, :integer
  end
end
