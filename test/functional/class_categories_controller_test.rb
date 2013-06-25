require 'test_helper'

class ClassCategoriesControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:class_categories)
    assert_response :success
    assert_template :index
  end

  test "should show class category" do
    get :show, :id => ClassCategory.find(:first).id
    
    assert_not_nil assigns(:class_category)
    assert_not_nil assigns(:class_sub_category)
    assert_template :show
  end
  
  test "should get new class category" do
     get :new

     assert_not_nil assigns(:class_category)
     assert_template :new
   end
  
  test "should create class category" do
    assert_difference('ClassCategory.count', 1) do
      post :create, :class_category => { :title => "New class category title" }
    end
    
    assert_not_nil assigns(:class_category)
    assert_redirected_to assigns(:class_category)
  end
  
  test "should get edit action" do
    get :edit, :id => ClassCategory.find(:first).id

    assert assigns(:class_category)
    assert_template :edit
  end
  
  test "should update class category" do
    put :update, :id => ClassCategory.first.id, :class_category => { :title => "Change title" }
    
    assert_equal ClassCategory.first.title, "Change title"
    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:class_category)
    assert_redirected_to assigns(:class_category)
  end

  test "should destroy class category" do
    assert_difference('ClassCategory.count', -1) do
     delete :destroy, :id => class_categories(:regular)
    end

    assert_redirected_to class_categories_url
  end
  
  test "should sort class categories" do
    
  end

end
