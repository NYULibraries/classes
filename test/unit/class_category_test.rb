require 'test_helper'

class ClassCategoryTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @class_category = class_categories(:regular)
    @class_category_html = class_categories(:html)
  end
  
  test "sub categories relation" do
    assert_not_empty @class_category.class_sub_categories
    assert_equal @class_category.class_sub_categories.count, 3
    @class_category.class_sub_categories.each do |subcat|
      assert_equal subcat.class_category, @class_category
    end
  end
  
  test "library classes relation" do
    assert_not_empty @class_category.library_classes
    assert_equal @class_category.library_classes.count, 5
    @class_category.library_classes.each do |libclass|
      assert_equal libclass.class_category, @class_category
    end
  end
  
  test "visible scope" do
    ClassCategory.visible.each do |cat|
      assert cat.visible?, "#{cat.title} is not visible, but should be"
    end
  end
  
  test "is visible boolean function" do 
    assert @class_category.visible?
    assert !class_categories(:hidden).visible?
  end
  
  test "title is required" do
    class_category = ClassCategory.new
    assert class_category.invalid?
    class_category.title = "T is for title, that's good enough for me"
    assert class_category.valid?
    assert_nothing_raised() { class_category.save! }
  end
    
end