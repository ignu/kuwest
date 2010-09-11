require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require 'action_mailer/railtie'
# require 'active_resource/railtie'
# require 'rails/test_unit/railtie'
#require 'action_controller/railtie'
require 'rails/all' 


# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)
#require 'dm-rails/railtie'

module Kuwest
  class Application < Rails::Application
    config.middleware.use "PDFKit::Middleware", :print_media_type => true
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_record.observers = [:win_observer, :comment_observer, :user_observer]
  end
end

