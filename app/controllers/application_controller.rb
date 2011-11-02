class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time
  
  helper_method :current_user
  
  require File.join(Rails.root, 'lib', 'authenticated_system.rb')
  include AuthenticatedSystem 

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
    
    def permission_denied
      respond_to do |format|
        flash[:error] = 'Sorry, you are not allowed to view the requested page.'
    	  redirect_to taxonomies_path
      end
    end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
end
