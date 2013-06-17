# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Stylesheets include helper
  def catalog_stylesheets
    catalog_stylesheets = stylesheet_link_tag "http://fonts.googleapis.com/css?family=Muli"
    catalog_stylesheets += stylesheet_link_tag "application"
  end
  
  # Javascripts include helper
  def catalog_javascripts
    catalog_javascripts = javascript_include_tag "application"
  end
  
  # Application title
  def application_title
    t("application_title")
  end
  
  def format_class_date(class_date)
    "#{class_date.to_formatted_datetime} #{class_date.note} #{(class_date.cancelled?) ? '<span class="cancelled">Cancelled</span>' : ''} #{(class_date.is_full?) ? '<span class="full">Full</span>' : ''}".html_safe
  end
  
  # Return formatted detail where breaking spaces are converted to <p>s
  def get_formatted_detail(purpose, css = nil)
    simple_format(get_sanitized_detail(purpose).html_safe, :class => css)
  end
  
  # Allow some html tags in application_detail
  def get_sanitized_detail(purpose)
    sanitize(get_application_detail_by_purpose(purpose).the_text.html_safe, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
  def get_application_detail_by_purpose(purpose)
    instance_variable_set("@#{purpose}", ApplicationDetail.find_by_purpose(purpose))
  end
  
end
