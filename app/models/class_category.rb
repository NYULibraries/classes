class ClassCategory < ActiveRecord::Base
  
  attr_accessible :title, :visible, :url, :external, :foot_text, :head_text
  validates_presence_of :title
  
  has_many :class_sub_categories, :dependent => :destroy, :order => "position ASC" 
  has_many :library_classes, :dependent => :destroy, :order => "position ASC"
  
  default_scope :order => "position ASC"
  scope :visible, where(:visible => true)

  def is_visible?
    self.visible?
  end
  
  def title_sanitized
    ActionController::Base.helpers.sanitize(self.title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
end
