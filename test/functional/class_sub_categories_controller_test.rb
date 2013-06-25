require 'test_helper'

class ClassSubCategoriesControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end

  test "should create class subcategory" do
    assert_difference('ClassSubCategory.count', 1) do
      post :create, :class_sub_category => { :title => "New class subcategory title", :class_category_id => class_categories(:regular).id }
    end
    
    assert_not_nil assigns(:class_sub_category)
    assert_not_nil assigns(:class_category)
    assert_redirected_to assigns(:class_category)
  end
  
  test "should get edit action" do
    get :edit, :id => ClassSubCategory.find(:first).id

    assert assigns(:class_sub_category)
    assert_template :edit
  end
  
  test "should update class subcategory" do
    put :update, :id => ClassSubCategory.first.id, :class_sub_category => { :title => "Change title" }
    
    assert_equal ClassSubCategory.first.title, "Change title"
    assert_not_nil assigns(:class_category)
    assert_not_nil assigns(:class_sub_category)
    assert_redirected_to assigns(:class_category)
  end

  test "should destroy class subcategory" do
    assert_difference('ClassSubCategory.count', -1) do
     delete :destroy, :id => class_sub_categories(:regular)
    end

    assert_not_nil assigns(:class_sub_category)
    assert_redirected_to assigns(:class_sub_category).class_category
  end
  
  test "should sort class subcategories" do
    post :sort, :class_sub_category => [class_sub_categories(:regular).id, class_sub_categories(:hidden).id, class_sub_categories(:html).id], :format => :js
    
    assert_equal ClassSubCategory.find(class_sub_categories(:regular).id).position, 1
    assert_equal ClassSubCategory.find(class_sub_categories(:hidden).id).position, 2
    assert_equal ClassSubCategory.find(class_sub_categories(:html).id).position, 3
    assert_not_nil assigns(:class_sub_categories)
  end

end
