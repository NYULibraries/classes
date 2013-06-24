class Registration < ActiveRecord::Base
  
  attr_accessible :attended, :class_date_id
  
  belongs_to :class_date
  belongs_to :user
  
  validates_presence_of :user_id
  validates :class_date_id, :presence => { :message => "is blank. Please select at least one class." }
  validates_uniqueness_of :class_date_id, :scope => :user_id, :message => " is a dupliate. You are already registered for the selected timeslot."

private
  
  def duplicate_registration
    "You are already registered for <strong>#{self.class_date.library_class.title}</strong> for the selected timeslot."
  end
  
end
