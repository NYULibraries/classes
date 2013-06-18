namespace :cleanup do

    desc "Cleanup users who have been inactive for over a year"
    task :users => :environment do
      # Call clear_users function in users
    end
  
end