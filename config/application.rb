require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require 'action_mailer/railtie'
# require 'active_resource/railtie'
# require 'rails/test_unit/railtie'
#require 'action_controller/railtie'
require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Kuwest
  ActiveSupport::Deprecation.silenced = true
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_record.observers = [:win_observer, :comment_observer, :user_observer]
    config.action_controller.allow_forgery_protection = false
  end
end

