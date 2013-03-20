# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  session :session_key => '_bookshop_session_id'

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
  def authorize
    unless Administrator.find_by_id(session[:administrator_id])
      flash[:notice] = "Please login as an administrator "
      redirect_to :controller => :admin, :action => :login
    end
  end

  def allow_user
    unless User.find_by_id(session[:user_id]) or Administrator.find_by_id(session[:administrator_id])
      flash[:notice] = "Please login"
      redirect_to :controller => :log_user, :action => :u_login
    end
  end
  def authen_upload
    unless User.find_by_id(session[:user_id]) or Administrator.find_by_id(session[:administrator_id])
      flash[:notice] = "Please login"
      redirect_to :controller => :log_user, :action => :u_login
    end
  end
end
