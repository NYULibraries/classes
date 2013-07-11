# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
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
  
  # Toggle collapse class based on session variable
  def collapse_class
    "out" unless session[:expand_all]
    "in" if session[:expand_all]
  end
  
  # Toggle collapse arrow class based on session variable
  def toggle_collapse_icon
    return icon_tag :arrow_right unless session[:expand_all]
    return icon_tag :arrow_down if session[:expand_all]  
  end
  
end
