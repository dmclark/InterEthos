class ActivationsController < ApplicationController
    def create
      @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
      raise Exception if @user.active?

      respond_to do |format|
        if @user.activate!
          UserSession.create(@user, false) # Log user in manually
          UserMailer.welcome(@user).deliver!
          format.html { redirect_to(root_url, :notice => 'Your account has been activated, and you are now logged in!') }
          format.xml { render :xml => @user, :status => :created, :location => @user }
        else
          render :action => :new
        end
      end
    end
end
