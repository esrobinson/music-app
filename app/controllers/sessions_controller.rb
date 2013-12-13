class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params)
    if @user
      login!(@user)
      flash[:notices] = ["Login successful"]
      redirect_to bands_url
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
