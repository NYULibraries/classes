require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @registration = registrations(:one)
  end
  
  test "class date association" do
    assert_equal @registration.class_date, class_dates(:one)
  end
  
  test "user association" do
    assert_equal @registration.user, users(:real_user)
  end
  
  test "class date is required" do
    registration = Registration.new
    registration.user = users(:real_user)
    assert registration.invalid?
  end
  
  test "user is required" do
    registration = Registration.new
    registration.class_date = class_dates(:one)
    assert registration.invalid?
  end
  
  test "class date and user combo is unique" do
    assert @registration.dup.invalid? 
  end
  
  test "was attended flag" do
    assert registrations(:three).attended?
  end
  
end