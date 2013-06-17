class AddWherefromToUsers < ActiveRecord::Migration
  def up
    add_column :users, :wherefrom, :string
  end
  
  def down
    remove_column :users, :wherefrom
  end
end
