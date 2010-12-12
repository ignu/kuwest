
Rails.env ||= "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')


require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/rspec'
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'

require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'
require 'cucumber/rails/capybara_javascript_emulation' # Lets you click links with onclick javascript handlers without using @culerity or @javascript
Capybara.default_selector = :css
Capybara.javascript_driver = :akephalos
ActionController::Base.allow_rescue = false

#Cucumber::Rails::World.use_transactional_fixtures = true
# How to clean your database when transactions are turned off. See
# http://github.com/bmabey/database_cleaner for more info.
if defined?(ActiveRecord::Base)
  begin
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
  rescue LoadError => ignore_if_database_cleaner_not_present
  end
end
Cucumber::Rails::World.use_transactional_fixtures = false
#require "#{Rails.root}/spec/support/blueprints" # or wherever they live

#TODO: consider http://openhood.com/rack/ruby/2010/07/15/rack-test-warning/ as a solution
$VERBOSE=nil
