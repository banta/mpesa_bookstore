class AdminController < ApplicationController
  before_filter :authorize, :except => :login
  def login
    session[:administrator_id] = nil
    if request.post?
      administrator = Administrator.authenticate(params[:email], params[:password])
      if administrator
        session[:user_id] = nil
        session[:administrator_id] = administrator.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:action => "index"})
      else
        flash.now[:notice] = "Invalid Administrator. Try again or register."
      end
    end
  end

  def destroy
    @administrator = Administrator.find(params[:id])
    begin
      @administrator.destroy
      flash[:notice] = "Administrator #{administrator.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(administrators_url) }
      format.xml {head :ok}
    end
  end

  def logout
    session[:administrator_id] = nil
    flash[:notice] = "Sucessifuly logged out"
    redirect_to(:action => "login")
  end

  def index
  end

end
