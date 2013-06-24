namespace :cleanup do

    desc "Cleanup users who have been inactive for over a year"
    task :users => :environment do
      # Clear inactive users from rake
      User.non_admin.inactive.destroy_all
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