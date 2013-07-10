require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end
  
  test "should get index" do
    get :index
    
    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:library_classes)
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:registration)
    assert_not_nil assigns(:suggestion)
    
    assert_template :index
  end
  
  test "should get specific category" do
    get :index, :params => { :class_category_id => class_categories(:regular) }
      
    assert_template :index
  end
  
end