source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'

gem 'mysql2', "~> 0.3.11"

gem 'json', "~> 1.8.0"

gem 'net-ldap', "~> 0.3.1"

gem 'rake', "~> 10.0.4"

gem 'coffee-rails', '~> 3.2.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.0'
  gem 'compass-susy-plugin', '~> 0.9.0'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', "~> 0.11.4", :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor', "~> 0.9.6"
end

group :development do 
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  #Testing coverage
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'ruby-prof' #For Benchmarking
  gem 'coveralls', "~> 0.6.2", :require => false
  gem "vcr", "~> 2.5.0"
  gem "webmock", "~> 1.11.0"
end

gem 'debugger', :group => [:test, :development]

gem 'authpds-nyu', "~> 0.2.12"
gem 'jquery-rails', "~> 2.2.1"
gem 'sunspot_rails', "~> 2.0.0"
gem 'acts-as-taggable-on', '~> 2.4.0'

# Deploy with Capistrano
gem "rake_nyu", :git => "git://github.com/NYULibraries/rake_nyu.git"

gem "sorted", "~> 0.4.3"
gem "kaminari", "~> 0.14.1"
gem "simple_form", "~> 2.1.0"
gem "best_in_place", "~> 2.1.0"

#gem 'nyulibraries_assets', :path => '/apps/nyulibraries_assets'
gem 'nyulibraries_assets', :git => 'git://github.com/NYULibraries/nyulibraries_assets.git', :tag => "v1.1.9"

gem 'unicode', "~> 0.4.3" #optionally used by blacklight
gem 'mustache-rails', "~> 0.2.3", :require => 'mustache/railtie'

# For memcached
gem 'dalli', "~> 2.6.2"

gem 'newrelic_rpm', "~> 3.6.0"

gem "comma", "~> 3.0.4"
