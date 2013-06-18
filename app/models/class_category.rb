class ClassCategory < ActiveRecord::Base
  
  attr_accessible :title, :visible, :url, :external, :foot_text, :head_text
  validates_presence_of :title
  
  has_many :class_sub_categories, :dependent => :destroy, :order => "class_sub_categories.position ASC" 
  has_many :library_classes, :dependent => :destroy, :order => "library_classes.position ASC"
  
  default_scope :order => "class_categories.position ASC"
  scope :visible, where(:visible => true)

  def is_visible?
    self.visible?
  end
  
  def title_sanitized
    ActionController::Base.helpers.sanitize(self.title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
  def title_formatted
    ActionController::Base.helpers.strip_tags(self.title).parameterize
  end
  
end
