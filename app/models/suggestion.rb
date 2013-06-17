class Suggestion < ActiveRecord::Base
  attr_accessible :fullname, :suggestion, :email
  validates :email, :allow_blank => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates_presence_of :suggestion
  
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
