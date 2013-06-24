require 'test_helper'

class ClassDateTest < ActiveSupport::TestCase

  setup :activate_authlogic
  
  def setup
    @class_date = class_dates(:one)
    @class_date_attrs = {:capacity => 1, :the_date => Time.now, :library_class_id => library_classes(:regular).id }
  end
  
  test "registrations relation" do
    assert_not_empty @class_date.registrations
    assert_equal @class_date.registrations.count, 3
    @class_date.registrations.each do |registration|
      assert_equal registration.class_date, @class_date
    end
  end
  
  test "library class relation" do
    assert_equal @class_date.library_class, library_classes(:regular)
  end
  
  test "for tomorrow scope" do
    assert_not_empty ClassDate.for_tomorrow
    ClassDate.for_tomorrow.each do |class_date|
      assert_equal class_date.the_date.strftime("%Y%m%d"), Time.now.tomorrow.strftime("%Y%m%d")
    end
  end
  
  test "is full boolean function" do 
    assert @class_date.full?
    assert !class_dates(:three).full?
  end
  
  test "is cancelled boolean function" do
    assert !@class_date.cancelled?
    assert class_dates(:cancelled).cancelled?
  end
  
  test "is past boolean function" do
    assert class_dates(:twelve).past?
    assert !class_dates(:seven).past?
  end
  
  test "if radio button should be disabled" do
    assert class_dates(:twelve).disabled?
    assert class_dates(:cancelled).disabled?
    assert @class_date.disabled?
  end

  test "capacity is required" do
    class_date = ClassDate.new(@class_date_attrs.merge({:capacity => nil}))
    assert class_date.invalid?
  end
  
  test "capacity must be numeric" do
    class_date = ClassDate.new(@class_date_attrs.merge({:capacity => "test123"}))
    assert class_date.invalid?
  end
  
  test "library class relation is required" do
    class_date = ClassDate.new(@class_date_attrs.merge({:library_class_id => nil}))
    assert class_date.invalid?
  end
  
  test "the date is required" do
    class_date = ClassDate.new(@class_date_attrs.merge({:the_date => nil}))
    assert class_date.invalid?
  end
  
  test "instructors have to be properly formatted email" do
    class_date = ClassDate.new(@class_date_attrs.merge({:instructors => "dawknjadw"}))
    assert class_date.invalid?
    class_date = ClassDate.new(@class_date_attrs.merge({:instructors => "email@realmail.com, snooker"}))
    assert class_date.invalid?
    class_date = ClassDate.new(@class_date_attrs.merge({:instructors => "email@realmail.com, email2@realmail.org"}))
    assert class_date.valid?
  end

end