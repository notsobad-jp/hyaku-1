class AddTimesAndResultToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :times, :integer
    add_column :histories, :result, :integer
  end
end
