class ClassCategory < ActiveRecord::Base
  
  attr_accessible :title, :visible, :url, :external, :foot_text, :head_text
  validates_presence_of :title
  
  has_many :class_sub_categories, :dependent => :destroy
  has_many :library_classes, :dependent => :destroy
  
  default_scope order("class_categories.position ASC")
  scope :visible, where(:visible => true)

end
