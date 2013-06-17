class RenameNetidToUsernameInSuggestions < ActiveRecord::Migration
  def up
    rename_column :suggestions, :netid, :username
  end

  def down
    rename_column :suggestions, :username, :netid
  end
end
