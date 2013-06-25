require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end
  
#  test "should get edit action" do
#    get :edit, :id => registrations(:one).id
#
#    assert assigns(:registration)
#    assert_template :edit
#  end
#  
#  test "should update registration" do
#    put :update, :id => Registration.first.id, :registration => { :attended => true }
#    
#    assert_equal Registration.first.attended, true
#    assert assigns(:registration)
#  end
#  
#  test "should destroy registration" do
#    assert_difference('Registration.count', -1) do
#     delete :destroy, :id => registrations(:four).id
#    end
#    
#    assert_not_nil assigns(:registration)
#    
#    assert_redirected_to assigns(:registration).class_date
#  end

end