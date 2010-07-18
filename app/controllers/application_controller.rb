
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include Twitter::Login::Helpers

  
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

end
