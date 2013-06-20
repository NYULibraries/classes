require 'test_helper'

class ClassSubCategoryTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @class_sub_category = class_sub_categories(:regular)
    @class_sub_category_html = class_sub_categories(:html)
  end
  
  test "library classes relation" do
    assert_not_empty @class_sub_category.library_classes
    assert_equal @class_sub_category.library_classes.count, 2
    @class_sub_category.library_classes.each do |libclass|
      assert_equal libclass.class_sub_category, @class_sub_category
    end
  end
  
  test "visible scope" do
    ClassSubCategory.visible.each do |subcat|
      assert subcat.is_visible?, "Sub-category: #{subcat.title} is not visible"
      assert subcat.class_category.is_visible?, "Category: #{subcat.class_category.title} is not visible"
    end
  end
  
  test "is visible boolean function" do 
    assert @class_sub_category.is_visible?
    assert !class_sub_categories(:hidden).is_visible?
  end
  
  test "title is required" do
    class_sub_category = ClassSubCategory.new
    assert class_sub_category.invalid?
    class_sub_category.title = "T is for title, that's good enough for me"
    assert class_sub_category.invalid?
    class_sub_category.class_category = class_categories(:regular)
    assert class_sub_category.valid?
    assert_nothing_raised() { class_sub_category.save! }
  end
  
  test "title is sanitized" do
    assert_equal @class_sub_category_html.title_sanitized, "Don't use font tags jeez!"
  end
  
end