namespace :cleanup do

    desc "Cleanup users who have been inactive for over a year"
    task :users => :environment do
      # Clear inactive users from rake
      User.non_admin.inactive.destroy_all
    end
    
    desc "Resave all existing users to resolve a bug; should only have to be done once at migration time"
    task :existing_users => :environment do
      User.all.each do |user|
        begin
          user.save!
        rescue Exception => e
          puts "Failed to save due to #{e}\n"
          puts "Deleting user #{user.username} last updated at #{user.updated_at}\n\n"
          user.destroy
        end
      end
    end
    
    desc "Add User relation to suggestion where username exists"
    task :suggestions => :environment do
      @suggestions = Suggestion.where("username IS NOT NULL")
      @suggestions.each do |suggestion|
        user = User.find_by_username(suggestion.username)
        unless user.nil?
          suggestion.update_attributes({:user_id => user.id}) 
        end
      end
    end
  
end