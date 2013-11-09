# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  include AuthenticatedSystem

  skip_before_filter :ensure_proper_protocol unless RAILS_ENV == 'production'
  # before_filter :login_required
  # before_filter :login_from_cookie  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_ivy_session_id'
end
