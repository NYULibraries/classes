require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup :activate_authlogic
  
  test "user search" do
    assert_instance_of ActiveRecord::Relation, User.search(false)
    assert_not_empty User.search("Marcus T")
    assert_not_empty User.search("Admin")
    assert_not_empty User.search("admin")
    assert_empty User.search("noemail@university.edu")
  end

  test "non admin scope" do
    assert_not_empty User.non_admin
    User.non_admin.each do |user|
      assert (user.user_attributes.nil? || !user.user_attributes[:classes_admin]), "#{user.username} is an admin, but shouldn't be"
    end
  end
  
  test "inactive user scope" do
    assert_not_empty User.inactive
    User.inactive.each do |user|
      assert_empty user.registrations
    end
  end
  
  test "user admin boolean" do
    assert !users(:nonadmin1).is_admin?
    assert users(:admin).is_admin?
    assert !users(:real_user).is_admin?
  end
  
end
