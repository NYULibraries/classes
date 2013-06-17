namespace :cleanup do

    desc "Cleanup users who have been inactive for over a year"
    task :users => :environment do
      @log = Logger.new("log/destroy_inactive_users.log")
      destroyed = User.destroy_all(["last_request_at IS NOT NIL AND last_request_at < ?", 1.year.ago])
      @log.error "[#{Time.now.to_formatted_s(:db)}] #{destroyed.count} users destroyed"
    end
  
end