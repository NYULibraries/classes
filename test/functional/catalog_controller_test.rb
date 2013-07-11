require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "should get index" do
    get :index
    
    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:library_classes)
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:registration)
    assert_not_nil assigns(:suggestion)
  end
  
  test "should get specific category" do
    get :index, :params => { :class_category_id => class_categories(:regular) }
  end
  
  test "should get logged in index" do
    current_user = UserSession.create(users(:real_user))
    
    get :index
    
    assert_template :index
  end
  
  test "should create a registration from catalog" do
    class_date = class_dates(:one)
    assert_difference('Registration.count', 1) do
      post :create, :class_date => {class_date.library_class_id => class_date.id}, :user => {:username => users(:nonadmin1).username}, :suggestion => { :suggestion => "Suggest this!" }
    end

    assert_not_nil assigns(:class_categories)
    assert_not_nil assigns(:library_classes)
    assert_not_nil assigns(:user)
    assert_not_empty assigns(:user).suggestions
    assert_not_nil assigns(:registration)
    assert_not_nil assigns(:suggestion)
    
    assert_redirected_to root_url
  end
  
  test "should have user errors" do
    class_date = class_dates(:one)
    assert_no_difference('Registration.count') do
      post :create, :class_date => {class_date.library_class_id => class_date.id}, :user => {:username => "nonameman"}
    end
  
    assert_not_empty assigns(:user).errors
    assert_template :index
  end
  
  test "should have registration errors" do
    class_date = class_dates(:one)
    assert_no_difference('Registration.count') do
      post :create, :class_date => {class_date.library_class_id => nil}, :user => {:username => users(:nonadmin1).username}
    end
    
    assigns(:user).registrations.each do |reg|
      assert_not_empty reg.errors  
    end
    assert_template :index
  end
  
  test "should autofill user fields" do
    get :autofill_user_fields, :user => { :username => "real_user" }
    
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:suggestion)
    assert_not_nil assigns(:registration)
    assert_template partial: '_user'
  end
  
  test "get new suggestion" do
    get :new_suggestion
    
    assert_not_nil assigns(:suggestion)
    
    assert_template :new_suggestion 
  end
  
  test "create new suggestion" do
    assert_difference('Suggestion.count',1) do
      post :create_suggestion, :suggestion => {:suggestion => "My new suggestion test"}
    end
    
    assert_redirected_to root_url
    assert_equal flash[:notice], I18n.t('catalog.flash.create_suggestion.notice')
  end
  
  test "doesn't create new suggestion" do
    assert_no_difference('Suggestion.count') do
      post :create_suggestion
    end

    assert_not_empty assigns(:suggestion).errors
    assert_template :new_suggestion
  end
  
end