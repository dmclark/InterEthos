class ApplicationController < ActionController::Base
  protect_from_forgery
   helper :all # include all helpers, all the time
   require File.join(Rails.root, 'lib', 'authenticated_system.rb')
 include AuthenticatedSystem 

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # Be sure to include AuthenticatedSystem in Application Controller instead
  include AuthenticatedSystem
  # before_filter :login_from_cookie
  # before_filter :set_current_user
  # before_filter { |c| Authorization.current_user = c.current_user }

  before_filter :set_current_user
  before_filter :get_ip
  before_filter :set_domain
  
  protected
    def set_current_user
      Authorization.current_user = current_user
    end
    
  def get_ip 
    @ip = request.remote_ip 
  end
    
  def set_domain
    # Extract domain
    this_domain = request.domain()
	
	if this_domain == "interethos.com"
		redirect_to "http://interethos.net"
		return
	end
	if this_domain == "interethos.org"
		redirect_to "http://interethos.net"
		return
	end
  end
    
  # set_current_user sets the global current user for this request.  This
  # is used by model security that does not have access to the
  # controller#current_user method.  It is called as a before_filter.
  def set_current_user
    Authorization.current_user = current_user
  end
  
  def permission_denied
    respond_to do |format|
      flash[:error] = 'Sorry, you are not allowed to view the requested page.'
	  redirect_to taxonomies_path
    end
  end

end
