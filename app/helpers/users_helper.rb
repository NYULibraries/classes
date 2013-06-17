module UsersHelper
  
  # Link to user record if user exists  
  def link_to_user(username)
     @user = User.find_by_username(username)
     link_to_unless(@user.nil?, username, @user, :alt => "Link to user", :title => "Link to user")
  end
   
end
