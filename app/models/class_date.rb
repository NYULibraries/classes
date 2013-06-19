class ClassDate < ActiveRecord::Base
  
  attr_accessible :the_date, :capacity, :note, :instructors, :library_class_id, :cancelled
	validates_presence_of :the_date, :library_class_id, :capacity
	validates_numericality_of :capacity, :on => :create, :only_integer => true
	validates :instructors,
      :allow_blank => true,
      :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})(,(\s)*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))*\z/i}
		
	belongs_to :library_class
	has_many :registrations, :dependent => :destroy
	has_many :users, :through => :registrations
	
  default_scope :order => 'the_date ASC'
  scope :for_tomorrow, lambda { where("DATE_FORMAT(the_date, '%Y%m%d') = ?", Time.now.tomorrow.strftime("%Y%m%d")) }
  
  def to_formatted_datetime
    self.the_date.strftime("%a., %b %d %Y \u2014 %I:%M%p")
  end
  
  def is_full?
    self.capacity <= self.registrations.size
  end
  
  def is_cancelled?
    self.cancelled
  end
  
  def is_past?
    the_date.strftime("%Y%m%d%M%H").to_i <= Time.now.strftime("%Y%m%d%M%H").to_i
  end
  
  # Disable ability to register for class if class date is:
  # * full
  # * cancelled; or
  # * in the past
  def is_disabled?
    self.is_full? or self.is_cancelled? or self.is_past?
  end
end
