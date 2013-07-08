class ApplicationController < ActionController::Base

  protect_from_forgery
  layout Proc.new{ |controller| (controller.request.xhr?) ? false : "application" }

  # Adds authentication actions in application controller
  require 'authpds'
  include Authpds::Controllers::AuthpdsController

  # Return boolean if user is logged out or is admin
  #def is_admin?
  #  return (!current_user.nil? && current_user.is_admin?)
  #end
  #helper_method :is_admin?
  #
  def is_admin?
    if current_user.nil? or current_user.user_attributes.blank? or current_user.user_attributes[:classes_admin].blank?
      return false
    else
      return (current_user.user_attributes[:classes_admin] == true)
    end
  end
  helper_method :is_admin? 
  
  # Filter users to root if not admin
  def authenticate_admin
    if is_admin?
      return true
    else
      redirect_to root_path and return unless performed?
    end
  end
  
  # For dev purposes
  def current_user_dev
   @current_user ||= User.find_by_username("ba36")
  end
  alias :current_user :current_user_dev if Rails.env == "development"

  # Return boolean matching the url to find out if we are in the admin view
  def is_in_admin_view?
    !request.path.match("/admin").nil?
  end
  helper_method :is_in_admin_view?

end
