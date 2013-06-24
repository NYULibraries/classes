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
  
  def format_class_date_title(class_date)
    "#{format_class_date_datetime(class_date)} #{class_date.note} #{(class_date.cancelled?) ? '<span class="cancelled">Cancelled</span>' : ''} #{(class_date.full?) ? '<span class="full">Full</span>' : ''}".html_safe
  end
  
  # Return formatted detail where breaking spaces are converted to <p>s
  def format_text_by_purpose(purpose, css = nil)
    simple_format(sanitize_text_by_purpose(purpose).html_safe, :class => css)
  end
  
  # Allow some html tags in application_detail
  def sanitize_text_by_purpose(purpose)
    sanitize(find_application_detail_by_purpose(purpose).the_text.html_safe, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
  # Set instance variable from app detail purpose
  def find_application_detail_by_purpose(purpose)
    instance_variable_set("@#{purpose}", ApplicationDetail.find_by_purpose(purpose))
  end
  
  # Sanitize title text
  def sanitize_title(title)
    sanitize(title, :tags => %w(a strong em), :attributes => %w(name target href class))
  end
  
  # Parameterize title text
  def parameterize_title(title)
    strip_tags(title).parameterize
  end
  
  # Format class date date for view
  def format_class_date_datetime(class_date)
    class_date.the_date.strftime("%a., %b %d %Y \u2014 %I:%M%p")
  end
  
end
