module ResponseEmailsHelper

  # Replace tokens for followup email
  def format_followup_tokens(body)
    body.gsub!(/\%class_date/,@class_date.the_date.strftime("%a., %b %d, %Y -- %I:%M%p"))
    body.gsub!(/\%class/,@class_date.library_class.title)
  end

  # Display which tokens are available for the response emails
  def available_tokens
    available_tokens = "Available tokens: "
  	case @response_email.purpose
  	when "auto_response"
  		available_tokens += "%name, %email, %phone, %program, %school, %status, %suggestion, and %classes."
  	when "auto_reminder"
  		available_tokens += "%class and %class_location."
  	when "follow_up"
  		available_tokens += "%class and %class_date."
  	when "auto_instructor_reminder"
  		available_tokens += "%class, %class_location, %registrations_count and %registrations."
  	else
  		available_tokens += "&lt;none&gt;"
  	end
  	return available_tokens
  end

end