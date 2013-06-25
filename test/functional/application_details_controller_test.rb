require 'test_helper'

class ApplicationDetailsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end
  
  test "should get edit action" do
    get :edit, :id => ApplicationDetail.find(:first).id

    assert assigns(:application_detail)
    assert_template :edit
  end
  
  test "should update detail" do
    put :update, :id => ApplicationDetail.first.id, :application_detail => { :the_text => "Change application detail text" }
    
    assert_equal ApplicationDetail.first.the_text, "Change application detail text"
    assert assigns(:application_detail)
    assert_redirected_to library_classes_url
  end

end