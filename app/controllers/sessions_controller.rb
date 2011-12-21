class SessionsController < ApplicationController
  after_filter :change_locale, :only => [:create]

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      remember_user(user)
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default("/")
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    forget_user
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
