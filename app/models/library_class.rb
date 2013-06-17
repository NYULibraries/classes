class LibraryClass < ActiveRecord::Base
  
  attr_accessible :title, :position, :class_category_id, :class_sub_category_id, :description, :location, :registration, :alt_registration_text, :visible
  validates_presence_of :title, :class_category_id
  has_many :class_dates, :dependent => :destroy, :order => "the_date ASC"
  
  belongs_to :class_sub_category
  belongs_to :class_category
  
  scope :ordered, :order => "position ASC"
  scope :visible, where(:visible => true)
  scope :in_order, includes(:class_category, :class_sub_category).order("class_categories.position ASC, class_sub_categories.position ASC, library_classes.position ASC")
  scope :without_sub_category, where(:class_sub_category_id => nil)
    
  def is_visible?
    self.visible?
  end
  
  def title_sanitized
    ActionController::Base.helpers.sanitize(self.title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end

end
