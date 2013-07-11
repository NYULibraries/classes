require 'capistrano-nyu'

set(:app_title) { "classes" } unless exists?(:app_title)
set(:application) { "#{app_title}_repos" }

set :rvm_ruby_string, "1.9.3-p448"

# Git vars
set :repository, "git@github.com:NYULibraries/classes.git" 

# Rails specific vars
set :normalize_asset_timestamps, false

set :recpient, "web.services@library.nyu.edu"