# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.use_instantiated_fixtures  = false
  config.mock_with :mocha
  config.include Devise::TestHelpers, :type => :controller
  config.extend SessionHelpers,       :type => :controller
end
