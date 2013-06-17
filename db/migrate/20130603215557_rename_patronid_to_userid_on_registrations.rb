class RenamePatronidToUseridOnRegistrations < ActiveRecord::Migration
  def up
    rename_column :registrations, :patron_id, :user_id
  end

  def down
    rename_column :registrations, :user_id, :patron_id
  end
end
