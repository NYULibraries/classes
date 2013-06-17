namespace :reminder_emails do

  desc "Send an auto reminder to instructors teaching a class the night before."
  task :instructors_email => :environment do
    # Find all registrations for tomorrow
    # Send an email out to each set of instructors
  end
  
  desc "Send an auto reminder to students registered in the class the night before."
  task :students_email => :environment do
    # Find all registrations for tomorrow
    # Send an email with bcc list to all reigstered students
  end
  
end