class ClassSubCategory < ActiveRecord::Base
  
  attr_accessible :title, :visible, :url, :class_category_id
  validates_presence_of :title, :class_category_id
  
  belongs_to :class_category
  has_many :library_classes, :dependent => :nullify, :order => "position ASC"
  
  default_scope :order => "position ASC"
  scope :visible, where(:visible => true)
  
  def is_visible?
    self.visible?
  end
  
  def title_sanitized
    ActionController::Base.helpers.sanitize(self.title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
end
