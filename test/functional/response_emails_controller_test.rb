require 'test_helper'

class ResponseEmailsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end
  
  test "should get index" do
    get :index
    
    assert_not_nil assigns(:response_emails)
    assert_template :index
  end
  
  test "should get edit action" do
    get :edit, :id => response_emails(:one).id

    assert assigns(:response_email)
    assert_template :edit
  end
  
  test "should update email" do
    put :update, :id => ResponseEmail.first.id, :response_email => { :body => "Change body" }
    
    #assert_equal ResponseEmail.first.body, "Change body"
    #assert assigns(:response_email)
    #assert_redirected_to response_emails_url
  end
  
  test "should not update email" do
    put :update, :id => response_emails(:one).id, :response_email => { :reply_to => "" }
    
    assert assigns(:response_email)
    assert_template :edit
  end
  

end