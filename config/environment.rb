# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

Rails::Initializer.run do |config|

  config.gem 'devise'
  config.gem 'friendly_id'
  config.gem 'verbs'
  config.gem 'paperclip'
  config.gem 'chronic'
  config.gem 'twitter'
  config.gem 'delayed_job'
  config.gem 'delayed_paperclip'
  config.gem 'warden'
  config.gem 'will_paginate'
  config.gem 'formtastic'
  config.gem "rspec", :lib => false, :version => ">= 1.2.0"
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.0"
  config.gem 'shoulda'  
  config.gem 'haml'
  config.gem 'mocha'
  config.gem 'factory_girl'
  config.gem "compass", :version => ">= 0.10.1"
  config.gem "mocha"
  config.gem "timecop"
  
  config.gem 'twitter'
  config.gem 'twitter-login', :version => '~> 0.2.1', :lib => 'twitter/login'
  config.middleware.use 'Twitter::Login', :consumer_key => 'FwXG209iTDLYZ0ZTouw', :secret => 'NuOUDsaIF4lyUYaY62YIDDX7qb6JwmMECShrmIMVRM', :return_to => '/after_twitter_login'
  
  config.active_record.observers = [:win_observer, :comment_observer, :user_observer]
end
