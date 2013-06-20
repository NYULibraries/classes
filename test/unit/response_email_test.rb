require 'test_helper'

class ResponseEmailTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @response_email = ResponseEmail.new
    @response_email.reply_to = "test@test.com"
    @response_email.subject = "My Subject"
    @response_email.body = "My Body"
    @response_email.purpose = "testing_purposes_email"
  end

  test "required fields are present" do
    response_email = ResponseEmail.new
    assert response_email.invalid?
    response_email.reply_to = "email@realmail.com"
    assert response_email.invalid?
    response_email.subject = "Test subject"
    assert response_email.invalid?
    response_email.body = "My body"
    assert response_email.invalid?
    response_email.purpose = "test_email"
    assert response_email.valid?
  end
  
  test "purpose is unique" do
    response_email = @response_email
    assert_nothing_raised() { response_email.save! }
    response_email2 = @response_email.dup
    assert_raises(ActiveRecord::RecordInvalid) { response_email2.save! }
  end

end