namespace :reminder_emails do
  
  desc "Send an auto reminder to students registered in the class the night before."
  task :auto_reminders => :environment do
    # Find all registrations for tomorrow
    @class_dates = ClassDate.for_tomorrow

    @class_dates.each do |class_date|
      # Send an email with bcc list to all registered students
      RegistrationMailer.auto_reminder_email(class_date).deliver
      # Send a reminder email to the instructor
      RegistrationMailer.instructor_reminder_email(class_date).deliver
    end
  end
  
end