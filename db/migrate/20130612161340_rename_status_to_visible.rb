class RenameStatusToVisible < ActiveRecord::Migration
  def up
    rename_column :class_categories, :status, :visible
    rename_column :class_sub_categories, :status, :visible
    rename_column :library_classes, :status, :visible
  end

  def down
    rename_column :class_categories, :visible, :status
    rename_column :class_sub_categories, :visible, :status
    rename_column :library_classes, :visible, :status
  end
end
