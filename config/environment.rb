# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'devise'
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
 
end
