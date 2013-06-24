class ClassSubCategory < ActiveRecord::Base
  
  attr_accessible :title, :visible, :url, :class_category_id
  validates_presence_of :title, :class_category_id
  
  belongs_to :class_category
  has_many :library_classes, :dependent => :nullify, :order => "library_classes.position ASC"
  
  default_scope order("class_sub_categories.position ASC")
  scope :visible, joins(:class_category).where("class_categories.visible = 1 AND class_sub_categories.visible = 1")

end
