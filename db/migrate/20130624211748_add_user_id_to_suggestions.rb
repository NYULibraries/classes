class AddUserIdToSuggestions < ActiveRecord::Migration
  def up
    add_column :suggestions, :user_id, :integer
  end
  
  def down
    remove_column :suggestions, :user_id
  end
end
