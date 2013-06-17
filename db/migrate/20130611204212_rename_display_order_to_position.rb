class RenameDisplayOrderToPosition < ActiveRecord::Migration
  def up
    rename_column :library_classes, :display_order, :position
    rename_column :class_categories, :display_order, :position
    rename_column :class_sub_categories, :display_order, :position
  end

  def down
    rename_column :library_classes, :position, :display_order
    rename_column :class_categories, :position, :display_order
    rename_column :class_sub_categories, :position, :display_order
  end
end
