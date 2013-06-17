class AddFieldsToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :netid, :username
    rename_column :users, :name, :fullname
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :session_id, :string
    add_column :users, :persistence_token, :string
    add_column :users, :login_count, :integer
    add_column :users, :last_request_at, :string
    add_column :users, :current_login_at, :string
    add_column :users, :last_login_at, :string
    add_column :users, :current_login_ip, :string
    add_column :users, :user_attributes, :text
    add_column :users, :refreshed_at, :datetime
  end
end

