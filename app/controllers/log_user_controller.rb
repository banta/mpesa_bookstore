class LogUserController < ApplicationController
  before_filter :allow_user, :except => :u_login
  def u_login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        session[:administrator_id] = nil
        redirect_to(:controller => :bookshop, :action => 'index' )
      else
        flash.now[:notice] = "Invalid user/password. Please sign up if you're not registered."
      end
    end
  end

  def u_logout
    session[:user_id] = nil
    flash[:notice] = "You're successfully Logged out"
    redirect_to(:action => "u_login" )
  end

  def index
  end

end