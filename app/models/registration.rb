class Registration < ActiveRecord::Base
  
  attr_accessible :attended
  
  belongs_to :class_date
  belongs_to :user
  
  validates_presence_of :class_date_id, :message => "Please select at least one class." 
  validates_uniqueness_of :class_date_id, :scope => :user_id, :message => "You have already registered for this timeslot."
  
  def was_attended?
    self.attended?
  end
  
end
