require 'test_helper'

class ClassDatesControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    current_user = UserSession.create(users(:admin))
  end

  test "should show class date" do
    get :show, :id => ClassDate.find(:first).id
    
    assert_not_nil assigns(:class_date)
    assert_not_nil assigns(:response_email)
    assert_template :show
  end
  
  test "should create class date" do
    assert_difference('ClassDate.count', 1) do
      post :create, :class_date => { :the_date => Time.now, :library_class_id => library_classes(:regular), :capacity => 2 }
    end
    assert_difference("LibraryClass.first.class_dates.count", 1) do
      post :create, :class_date => { :the_date => Time.now, :library_class_id => LibraryClass.first.id, :capacity => 2 }
    end
 
    assert_not_nil assigns(:class_date)
    assert_not_nil assigns(:library_class)
    assert_redirected_to assigns(:library_class)
  end
  
  test "should not create and redirect" do
    assert_no_difference('ClassDate.count', 1) do
      post :create, :class_date => { :the_date => Time.now, :library_class_id => library_classes(:regular) }
    end
    
    assert_not_nil assigns(:library_class)
    assert_response :redirect
  end
  
  test "should get edit action" do
    get :edit, :id => ClassDate.find(:first).id
 
    assert_not_nil assigns(:class_date)
    assert_not_nil assigns(:library_class)
    assert_template :edit
  end
  
  test "should update class date" do
    put :update, :id => class_dates(:one).id, :class_date => { :capacity => 18 }
    
    assert_equal ClassDate.find(class_dates(:one).id).capacity, 18
    assert_not_nil assigns(:library_class)
    assert_not_nil assigns(:class_date)
  end
 
  test "should destroy class date" do
    assert_difference('ClassDate.count', -1) do
     delete :destroy, :id => class_dates(:one).id
    end
 
    assert_redirected_to assigns(:class_date).library_class
  end
  
  test "should send follow up email" do
    post :send_follow_up, :class_date => class_dates(:one).id, :response_email => {:body => "Follow up", :subject => "Follow up subject"}
    
    assert_not_nil assigns(:class_date)
    assert_not_nil assigns(:registrations)
    assert_redirected_to assigns(:class_date)
  end

end
