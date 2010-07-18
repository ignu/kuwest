# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.mock_with :mocha
end

class ActionController::TestCase
  include Devise::TestHelpers
  def signin_as(email, username, password)
    user = User.create(:email => email, :password => password, :password_confirmation => password, :username => username)
    sign_in user
    user
  end

  def signin_mock
    user = mock_model(User) 
    sign_in user
    user
  end
end
