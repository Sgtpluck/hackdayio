class SessionsController < ApplicationController
  
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Sorry it doesn't look like you have access."
      redirect_to root_url
    end
  end

  def destroy
    session.delete(:user_id)
  	redirect_to root_url
  end
end