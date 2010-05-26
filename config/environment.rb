# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
# =>  RAILS_GEM_VERSION = '2.3.4' # unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'devise'
  config.gem 'chronic'
  config.gem 'warden'
  config.gem 'aws-s3', :lib=>"aws/s3"
  config.gem 'paperclip'
  config.gem 'formtastic'
  config.gem "rspec", :lib => false, :version => ">= 1.2.0"
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.0"
  config.gem 'shoulda'  
  config.gem 'haml'
  config.gem 'mocha'
  config.gem 'factory_girl'
  config.gem "compass", :version => ">= 0.10.1"
  
end
