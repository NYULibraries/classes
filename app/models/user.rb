class User < ActiveRecord::Base
  validate :ldap_auth
  attr_accessible :fullname, :email, :username, :phone, :program, :school, :status, :wherefrom
  validates_presence_of :fullname, :email, :phone, :program, :school, :status, :wherefrom
  validates_presence_of :username
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  has_many :registrations, :dependent => :destroy
  has_many :class_dates, :through => :registrations
  
  # Users without registrations
  scope :non_admin, where("user_attributes IS NULL OR user_attributes NOT LIKE '%:classes_admin: true%'")
  scope :inactive, lambda { includes(:registrations).where('registrations.id' => nil) }
  
  serialize :user_attributes
  
  acts_as_authentic do |c|
    c.validations_scope = :username
    c.validate_password_field = false
    c.require_password_confirmation = false  
    c.disable_perishable_token_maintenance = true
  end
  
  # Simple SQL search for common user attributes
  def self.search(search)
    if search
      q = "%#{search}%"
      where('firstname LIKE ? || lastname LIKE ? || fullname LIKE ? || username LIKE ? || email LIKE ?', q, q, q, q, q)
    else
      scoped
    end
  end
  
  # Export users as CSV
  comma do
    fullname "Name"
    email
    username "NetID"
    phone
    program
    school
    status
    wherefrom "How did you find out about the classes NYU Libraries offers?"
  end
  
  # Boolean if user is app admin
  def is_admin?
    if self.user_attributes.nil? or self.user_attributes[:classes_admin].nil?
      false
    else
      self.user_attributes[:classes_admin]
    end
  end
  
private

  # Verify submitted username is a valid NetID
  def ldap_auth
    auth = { :username => Settings.ldap.auth.username, :password => Settings.ldap.auth.password, :method => :simple }
    ldap = Net::LDAP.new(:host => Settings.ldap.auth.host, :port => Settings.ldap.auth.port, :encryption => :simple_tls, :auth => auth)

    treebase = Settings.ldap.treebase
    filter = Net::LDAP::Filter.eq("uid","#{username}")
    attrs = ["uid"]
    
    ldap.search(:base => treebase, :filter => filter, :attributes => attrs, :return_result => false) do |entry|
      return true
    end
    
    self.errors.add(:username, " is invalid. Must be a valid NYU NetID.")
    return false
  end
  
end
