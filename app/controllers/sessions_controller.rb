class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new    
  end

  def create
    if User.count.zero?
      redirect_to new_user_url
      return
    end
    
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Invalid user or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end

end