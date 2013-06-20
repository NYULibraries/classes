require 'test_helper'

class LibraryClassTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @library_class = library_classes(:regular)
    @library_class_html = library_classes(:html)
  end
  
  test "class dates relation" do
    assert_not_empty @library_class.class_dates
    assert_equal @library_class.class_dates.count, 13
    @library_class.class_dates.each do |class_date|
      assert_equal class_date.library_class, @library_class
    end
  end
  
  test "without sub category scope" do
    assert_not_empty LibraryClass.without_sub_category
    assert_equal LibraryClass.without_sub_category.count, 3
    LibraryClass.without_sub_category.each do |libclass|
      assert libclass.class_sub_category.nil?
    end
  end
  
  test "non-external scope" do
    assert_not_empty LibraryClass.non_external
    LibraryClass.non_external.each do |libclass|
      assert !libclass.class_category.external, "Category: #{libclass.class_category.title} is external"
    end
  end
  
  test "visible scope" do
    LibraryClass.visible.each do |libclass|
      assert libclass.is_visible?, "#{libclass.title} is not visible, but should be"
      assert libclass.class_category.is_visible?, "Category: #{libclass.class_category.title} is not visible"
      assert libclass.class_sub_category.is_visible?, "Sub-Category: #{libclass.class_sub_category.title} is not visible" unless  libclass.class_sub_category.nil?
    end
  end
  
  test "is visible boolean function" do 
    assert @library_class.is_visible?
    assert !library_classes(:hidden).is_visible?
  end
  
  test "title is required" do
    library_class = LibraryClass.new
    assert library_class.invalid?
    library_class.title = "T is for title, that's good enough for me"
    assert library_class.invalid?
    library_class.class_category = class_categories(:regular)
    assert library_class.valid?
    assert_nothing_raised() { library_class.save! }
  end
  
  test "title is sanitized" do
    assert_equal @library_class_html.title_sanitized, 'Why?'
  end

  
end