namespace :cleanup do

    desc "Cleanup users who have been inactive for over a year"
    task :users => :environment do
      # Clear inactive users from rake
      User.non_admin.inactive.destroy_all
    end
  
end