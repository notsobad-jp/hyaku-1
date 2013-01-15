class AddRes1AndRes3AndRes7AndResFinalToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :res_1, :integer
    add_column :histories, :res_3, :integer
    add_column :histories, :res_7, :integer
    add_column :histories, :res_final, :integer
  end
end
