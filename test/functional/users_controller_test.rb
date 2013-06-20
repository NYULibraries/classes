require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup :activate_authlogic

  def setup
   current_user = UserSession.create(users(:admin))
   @user_attrs = {"fullname"=>"John Smith", "email"=>"nonadmin1@university.edu", "phone"=>"1234567890", "program"=>"CompSci", "school"=>"NYU", "status"=>"JR", "firstname"=>"John", "lastname"=>"Smith", "wherefrom"=>"Professor"}
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:users)
    assert_response :success
    assert_template :index
  end

  test "search returns result" do
    get :index, :search => "Marcus"
    assert_not_nil assigns(:users)
  end
  
  test "should get edit action" do
    get :edit, :id => User.find(:first).id

    assert assigns(:user)
    assert_template :edit
  end

  test "should show user" do
    get :show, :id => User.find(:first).id
    assert_not_nil assigns(:user)
    assert_response :success
    assert_template :show
  end
  
  test "should toggle user admin status" do
    VCR.use_cassette('update user') do
      put :update, :id => users(:ba36).id, :user_attributes => { :classes_admin => "on" }, :user => @user_attrs
    end

    assert_not_nil assigns(:user)
    assert assigns(:user).user_attributes[:classes_admin], "Admin attr was not toggled"
    
    assert_redirected_to assigns(:user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
     delete :destroy, :id => users(:nonadmin1).id
    end

    assert_redirected_to users_path
  end
  
  test "should not destroy self" do
    assert_no_difference('User.count') do
     delete :destroy, :id => users(:admin).id
    end

    assert_not_nil assigns(:user)
    assert_redirected_to assigns(:user)
  end
  
  test "should destroy user registration" do
    assert_difference('Registration.count', -1) do
     delete :destroy_registration, :id => registrations(:four).id
    end
    
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:registration)
    
    assert_redirected_to assigns(:user)
  end
  
  test "should clear inactive users" do
    assert_difference('User.count', -2) do
      delete :clear_users
    end
    
    assert_redirected_to users_url
  end
  
  test "should get csv list" do
    get :index, :format => :csv
    
    assert_not_nil assigns(:users)
  end
   
end