class User < ActiveRecord::Base
 
  attr_accessible :fullname, :email, :username, :phone, :program, :school, :status, :wherefrom
  attr_accessible :crypted_password, :current_login_at, :current_login_ip, :email, :firstname, :last_login_at, :last_login_ip, :last_request_at, :lastname, :login_count, :mobile_phone, :password_salt, :persistence_token, :refreshed_at, :session_id, :user_attributes

  validate :ldap_authenticate
  validates_presence_of :fullname, :email, :phone, :program, :school, :status, :username, :wherefrom, :unless => lambda { :is_admin? }
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  #validates_associated :registrations

  has_many :registrations, :dependent => :destroy
  has_many :class_dates, :through => :registrations
  has_many :suggestions
  
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
    if self.user_attributes.blank? or self.user_attributes[:classes_admin].blank?
      return false
    else
      return (self.user_attributes[:classes_admin] == true)
    end
  end
  
private

  def ldap_auth_hash
    @ldap_auth_hash ||= { :username => Settings.ldap.auth.username, :password => Settings.ldap.auth.password, :method => :simple }
  end
  
  def ldap_connection
    @ldap_connection ||= Net::LDAP.new(:host => Settings.ldap.auth.host, :port => Settings.ldap.auth.port, :encryption => :simple_tls, :auth => ldap_auth_hash)
  end
  
  def ldap_treebase
    @ldap_treebase ||= Settings.ldap.treebase
  end
  
  def ldap_attrs
    @ldap_attrs ||= ["uid"]
  end

  # Verify submitted username is a valid NetID
  def ldap_authenticate 
    filter = Net::LDAP::Filter.eq("uid","#{username}")
    
    ldap_connection.search(:base => ldap_treebase, :filter => filter, :attributes => ldap_attrs, :return_result => false) do |entry|
      return true
    end
    
    self.errors.add(:username, " is invalid")
    return false
  end
  
end
