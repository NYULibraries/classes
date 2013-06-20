require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase

  test "suggestion search" do
    assert_instance_of ActiveRecord::Relation, Suggestion.search(false)
    assert_not_empty Suggestion.search("Fred")
    assert_not_empty Suggestion.search("real_user")
    assert_not_empty Suggestion.search("email@realmail.com")
    assert_not_empty Suggestion.search("My anonymous suggestions")
    assert_empty Suggestion.search("noemail@university.edu")
  end  
  
end
