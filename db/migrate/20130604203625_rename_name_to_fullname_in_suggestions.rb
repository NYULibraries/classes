class RenameNameToFullnameInSuggestions < ActiveRecord::Migration
  def up
    rename_column :suggestions, :name, :fullname
  end

  def down
    rename_column :suggestions, :fullname, :name
  end
end
