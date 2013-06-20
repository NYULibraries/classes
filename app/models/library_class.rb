class LibraryClass < ActiveRecord::Base
  
  attr_accessible :title, :position, :class_category_id, :class_sub_category_id, :description, :location, :registration, :alt_registration_text, :visible
  validates_presence_of :title, :class_category_id
  has_many :class_dates, :dependent => :destroy, :order => "the_date ASC"
  
  belongs_to :class_sub_category
  belongs_to :class_category
  
  # INNER JOIN ON class_category and LEFT OUTER JOIN ON class_sub_category
  # Because class_sub_category may sometimes be blank
  scope :visible, joins(:class_category).includes(:class_sub_category).where(:visible => true, :class_categories => { :visible => true }).where("class_sub_categories.visible = 1 OR class_sub_categories.visible IS NULL")
  scope :in_order, includes(:class_category, :class_sub_category).order("class_categories.position ASC, class_sub_categories.position ASC, library_classes.position ASC")
  scope :without_sub_category, where(:class_sub_category_id => nil)
  scope :non_external, joins(:class_category).where(:class_categories => { :external => false })
    
  def is_visible?
    self.visible?
  end
  
  def title_sanitized
    ActionController::Base.helpers.sanitize(self.title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end

end
