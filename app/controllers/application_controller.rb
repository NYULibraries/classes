class ApplicationController < ActionController::Base

  protect_from_forgery
  layout Proc.new{ |controller| (controller.request.xhr?) ? false : "application" }

  # Adds authentication actions in application controller
  require 'authpds'
  include Authpds::Controllers::AuthpdsController
  
  # Filter users to root if not admin
  def authenticate_admin
    if !is_admin?
      redirect_to root_path and return unless performed?
    else
      return true
    end
  end
  
  # For dev purposes
  def current_user_dev
   @current_user ||= User.find_by_username("ba36")
  end
  alias :current_user :current_user_dev if Rails.env == "development"

  # Return true if user is marked as admin
  def is_admin
  	if current_user.nil? or current_user.user_attributes.nil? or !current_user.user_attributes[:classes_admin]
      return false
    else
      return true
    end
  end
  alias :is_admin? :is_admin
  helper_method :is_admin?
 
  # Return boolean matching the url to find out if we are in the admin view
  def is_in_admin_view
    !request.path.match("/admin").nil?
  end
  alias :is_in_admin_view? :is_in_admin_view
  helper_method :is_in_admin_view?

end
