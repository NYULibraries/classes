require 'test_helper'

class SuggestionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:suggestions)
    assert_response :success
    assert_template :index
  end

  test "search returns result" do
    get :index, :search => "my suggestion"
    assert_not_nil assigns(:suggestions)
  end
  
  test "should create suggestions" do
    assert_difference('Suggestion.count', 1) do
      post :create, :suggestion => { :suggestion => "create new suggestion" }
    end
    
    assert_not_nil assigns(:suggestion)
    assert_redirected_to root_url
  end
  
  test "should show suggestion" do
    get :show, :id => Suggestion.find(:first).id
    
    assert_not_nil assigns(:suggestion)
    assert_template :show
  end
  
  test "should get edit action" do
    get :edit, :id => Suggestion.find(:first).id

    assert assigns(:suggestion)
    assert_template :edit
  end
  
  test "should update suggestion" do
    put :update, :id => Suggestion.first.id, :suggestion => { :suggestion => "Change suggestion" }
    
    assert_equal Suggestion.first.suggestion, "Change suggestion"
  end

  test "should destroy user" do
    assert_difference('Suggestion.count', -1) do
     delete :destroy, :id => suggestions(:with_user)
    end

    assert_redirected_to suggestions_url
  end
  
  test "should clear suggestions" do
    assert_difference('Suggestion.count', -2) do
      delete :clear_suggestions
    end
    
    assert_redirected_to suggestions_url
  end
  
  test "should get csv list" do
    get :index, :format => :csv
    
    assert_not_nil assigns(:suggestions)
  end
end
