require 'test_helper'

class ApplicationDetailTest < ActiveSupport::TestCase
 
 test "purpose is unique" do
   app_detail = ApplicationDetail.new({:purpose => "testing_purposes", :the_text => "my test text"}) 
   assert app_detail.valid?
   assert_nothing_raised() { app_detail.save! }
   app_detail_dupe = ApplicationDetail.new({:purpose => "testing_purposes", :the_text => "my test text2"}) 
   assert_raises(ActiveRecord::RecordInvalid) { app_detail_dupe.save! }
 end
 
 test "purpose is required" do
   app_detail = ApplicationDetail.new({:the_text => "my test text"})
   assert_raises(ActiveRecord::RecordInvalid) { app_detail.save! }
   app_detail.purpose = "testing_purpose_2"
   assert_nothing_raised() { app_detail.save! }
 end
 
 test "the_text is required" do
   app_detail = ApplicationDetail.new({:purpose => "testing_purpose_3"})
   assert_raises(ActiveRecord::RecordInvalid) { app_detail.save! }
   app_detail.the_text = "my test text"
   assert_nothing_raised() { app_detail.save! }
 end
 
end
