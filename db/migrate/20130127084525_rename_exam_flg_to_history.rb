class RenameExamFlgToHistory < ActiveRecord::Migration
  def up
    rename_column :histories, :exam_flg, :exam_id
  end

  def down
    rename_column :histories, :exam_id, :exam_flg
  end
end
