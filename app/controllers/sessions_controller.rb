class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params)
    if @user
      if @user.activated
        login!(@user)
        flash[:notices] = ["Login successful"]
        redirect_to bands_url
      else
        redirect_to not_activated_users_url
      end
    else
      flash.now[:notices] = ["Invalid email/password"]
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    logout!(current_user)
    redirect_to new_sessions_url
  end

end
