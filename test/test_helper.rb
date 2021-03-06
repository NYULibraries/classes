unless ENV['TRAVIS']
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
else
  require 'coveralls'
  Coveralls.wear!
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'authlogic'
require 'authlogic/test_case'

class User
  def nyuidn
    user_attributes[:nyuidn]
  end
  
  def error; end
  
  def uid
    username
  end
  
  def ldap_authenticate
    return true
  end
end

class ActiveSupport::TestCase
  fixtures :all
  
  def set_dummy_pds_user(user_session)
    user_session.instance_variable_set("@pds_user".to_sym, users(:real_user))
  end
end

# VCR is used to 'record' HTTP interactions with
# third party services used in tests, and play em
# back. Useful for efficiency, also useful for
# testing code against API's that not everyone
# has access to -- the responses can be cached
# and re-used. 
require 'vcr'
require 'webmock'

# To allow us to do real HTTP requests in a VCR.turned_off, we
# have to tell webmock to let us. 
WebMock.allow_net_connect!

#@@ldap_host = Settings.ldap.auth.host
#@@ldap_username = Settings.ldap.auth.username
#@@ldap_password = Settings.ldap.auth.password
#@@ldap_treebase = Settings.ldap.treebase

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock 
#  c.filter_sensitive_data("ldap.university.edu") { @@ldap_host }
#  c.filter_sensitive_data("uid=admin_user") { @@ldap_username }
#  c.filter_sensitive_data("ldappass123") { @@ldap_password }
#  c.filter_sensitive_data("ou=People") { @@ldap_treebase }
end