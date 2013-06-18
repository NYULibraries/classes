class RegistrationMailer < ActionMailer::Base
  default from: "libclass@nyu.edu",
          reply_to: "no-reply@library.nyu.edu"
  
  # Auto confirmation email after submission
  def confirmation_email(registrations)
    @response_email = ResponseEmail.find_by_purpose('auto_response')
    @body = format_confirmation_email(@response_email.body, registrations)
    mail(:to => registrations.first.user.email, :subject => @response_email.subject, :reply_to => @response_email.reply_to)
  end
  
  # Cancellation email
  def cancellation_email(registrations)
  end

  # Follow up email sent by instructor/admin after class
  def follow_up_email(response_email, registrations)
    @response_email = response_email
    recipients = registrations.map {|reg| (reg.user.email) if reg.was_attended? }
    mail(:to => "library-classes@library.nyu.edu", :bcc => recipients, :subject => @response_email.subject, :reply_to => @response_email.reply_to, :body => @response_email.body)
  end
  
  # Auto reminder to students in a class
  def reminder_email(registrations)
  end
  
  # Auto reminder to instructor teaching the course
  def instructor_reminder_email(registrations)
  end

private

  # Wrap user and class formatting
  def format_confirmation_email(body, registrations)
    body = format_email_classes(body, registrations)
    body = format_email_user_info(body, registrations.first.user)
    return body
  end
   
  # Format classes for email
  def format_email_classes(body, registrations)
    registrations_formatted = ""
    registrations.each do |registration|
      registrations_formatted += "#{registration.class_date.library_class.title} \u2014 #{registration.class_date.to_formatted_datetime}; Location: #{registration.class_date.library_class.location}\n"
    end
    body.gsub!(/\%classes/,registrations_formatted)
    return body
  end
  
  # Format user information for email
  def format_email_user_info(body, user)
    body.gsub!(/\%name/,user.fullname)
    body.gsub!(/\%email/,user.email)
    body.gsub!(/\%phone/,user.phone)
    body.gsub!(/\%program/,user.program)
    body.gsub!(/\%school/,user.school)
    body.gsub!(/\%status/,user.status)
    suggestion = Suggestion.where(:username => user.username).order("created_at").last
    unless suggestion.nil?
      body.gsub!(/\%suggestion/, suggestion.suggestion)
    end
    return body
  end
  
  # Format tokens for auto reminder
  def format_auto_reminder(body, registration)
    body.gsub!(/\%class_location/, registration.class_date.library_class.location)
    body.gsub!(/\%class/, "#{registration.class_date.library_class.title} \u2014 #{registration.class_date.to_formatted_datetime}")
  end
  
  # Format tokens for auto reminder to instructor
  def format_instructor_auto_reminder(body, class_date)
    body.gsub!(/\%class_location/, class_date.library_class.location)
    body.gsub!(/\%class/, "#{class_date.library_class.title} \u2014 #{class_date.to_formatted_datetime}")
    body.gsub!(/\%registrations_count/, class_date.registations.count)
    body = format_email_registrations(body, class_date.registrations)
  end
  
  # Format registrations for email
  def format_email_registrations(body, registrations)
    registrations_formatted = ""
    registrations.each do |registration|
     user = registration.user
     registrations_formatted += "#{user.name}, #{user.email}, #{user.school}, Major/Program: #{user.program}, Status: #{user.status}\n"
    end
    body.gsub!(/\%registrations/,registrations_formatted)
    return body
  end

end
