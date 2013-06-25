require 'test_helper'

class LibraryClassesControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:library_classes)
    assert_not_nil assigns(:class_categories)
    assert_response :success
    assert_template :index
  end

  test "should show library class" do
    get :show, :id => LibraryClass.find(:first).id
    
    assert_not_nil assigns(:library_class)
    assert_not_nil assigns(:class_date)
    assert_template :show
  end
  
  test "should get new library class" do
     get :new
 
     assert_not_nil assigns(:class_categories)
     assert_not_nil assigns(:class_sub_categories)
     assert_not_nil assigns(:library_class)
     assert_template :new
  end
  
  test "should set sub categories" do
     get :new, :format => :js, :library_class => { :class_category_id => class_categories(:regular).id }
 
     assert_not_nil assigns(:class_category) 
     assert_template :new
  end
  
  test "should create library class" do
    assert_difference('LibraryClass.count', 1) do
      post :create, :library_class => { :title => "New class title", :class_category_id => class_categories(:regular) }
    end
 
    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:class_sub_categories)
    assert_not_nil assigns(:library_class)
    assert_not_nil assigns(:class_category)
    assert_redirected_to assigns(:library_class)
  end
  
  test "should get edit action" do
    get :edit, :id => LibraryClass.find(:first).id
 
    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:class_sub_categories)
    assert_not_nil assigns(:library_class)
    assert_template :edit
  end
  
  test "should update library class" do
    put :update, :id => library_classes(:regular).id, :library_class => { :title => "Change title" }
    
    assert_equal LibraryClass.find(library_classes(:regular).id).title, "Change title"
    assert_not_nil assigns(:class_sub_categories)
    assert_not_nil assigns(:library_class)
    assert_not_nil assigns(:class_categories)
    assert_redirected_to assigns(:library_class)
  end
 
  test "should destroy library class" do
    assert_difference('LibraryClass.count', -1) do
     delete :destroy, :id => library_classes(:regular).id
    end
 
    assert_redirected_to library_classes_url
  end
  
  test "should sort library class" do
    post :sort, :library_class => [library_classes(:no_sub_cat).id, library_classes(:hidden).id, library_classes(:html).id], :format => :js
    
    assert_equal LibraryClass.find(library_classes(:no_sub_cat).id).position, 1
    assert_equal LibraryClass.find(library_classes(:hidden).id).position, 2
    assert_equal LibraryClass.find(library_classes(:html).id).position, 3
    assert_not_nil assigns(:library_classes)
  end
 
  test "should set session variable to set all" do
    get :expand_all, :format => :js, :expand_all => "true"
    
    assert_equal session[:expand_all], true
  end

end
