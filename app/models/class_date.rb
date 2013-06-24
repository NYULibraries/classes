class ClassDate < ActiveRecord::Base
  
  attr_accessible :the_date, :capacity, :note, :instructors, :library_class_id, :cancelled
  
	validates_presence_of :the_date, :library_class_id, :capacity
	validates_numericality_of :capacity, :on => :create, :only_integer => true
	# List of comma-delimited properly-formatted emails
	validates :instructors, :allow_blank => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})(,(\s)*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))*\z/i }
		
	belongs_to :library_class
	has_many :registrations, :dependent => :destroy
	
  default_scope order('the_date ASC')
  scope :for_tomorrow, lambda { where("DATE_FORMAT(the_date, '%Y%m%d') = ?", Time.now.tomorrow.strftime("%Y%m%d")) }
  
  def full?
    self.capacity <= self.registrations.size
  end
  
  def cancelled?
    self.cancelled
  end
  
  def past?
    self.the_date.strftime("%Y%m%d%M%H").to_i <= Time.now.strftime("%Y%m%d%M%H").to_i
  end
  
  # Disable ability to register for class if class date is:
  # * full
  # * cancelled; or
  # * in the past
  def disabled?
    self.full? or self.cancelled? or self.past?
  end
  
  def to_formatted_datetime
    self.the_date.strftime("%a., %b %d %Y \u2014 %I:%M%p")
  end
end
