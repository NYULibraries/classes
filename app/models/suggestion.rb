class Suggestion < ActiveRecord::Base
  attr_accessible :fullname, :suggestion, :email, :user_id, :username
  
  validates :email, :allow_blank => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates_presence_of :suggestion
  
  before_create :populate_user_fields
  
  def populate_user_fields
    unless self.user_id.nil?
      user = User.find(self.user_id)
      self.fullname = "#{user.firstname} #{user.lastname}"
      self.email = user.email
      self.username = user.username
    end
  end
  
  # Simple SQL search for common suggestion attributes
  def self.search(search)
    if search
      q = "%#{search}%"
      where('fullname LIKE ? || suggestion LIKE ? || email LIKE ? || username LIKE ?', q, q, q, q)
    else
      scoped
    end
  end
  
  # Create a CSV format
  comma do
    created_at 'Date submitted' do |created_at| created_at.to_s end
    fullname 'Name'
    username 'NetID'
    email
    suggestion
  end
  
end
