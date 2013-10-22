class SessionsController < ApplicationController
  skip_before_filter :is_logged_in

  def new
    redirect_to user_path(@current_user) if current_user
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to user_path(user), notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end
end
