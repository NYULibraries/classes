class Registration < ActiveRecord::Base
  
  attr_accessible :attended, :class_date_id
  
  belongs_to :class_date
  belongs_to :user
  
  validates_presence_of :user_id, :class_date_id
  validates_uniqueness_of :class_date_id, :scope => :user_id
  
end
