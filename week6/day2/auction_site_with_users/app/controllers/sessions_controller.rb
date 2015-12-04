class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to login_path
    end  
  end

  def destroy
    session.clear
    redirect_to '/'
  end

end
