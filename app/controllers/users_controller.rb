class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(params[:user])
    @user.activated = false
    if @user.save
      flash[:notices] = ["User created!"]
      activation_email(@user)
      redirect_to not_activated_users_url
    else
      flash.now[:notices] = @user.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    if @user.activate!
      flash[:notices] = ["Activated!"]
      redirect_to new_sessions_url
    else
      flash.now[:notices] = @user.errors.full_messages
      render :index
    end
  end

  def not_activated
    render :not_activated
  end

  private

  def activation_email(user)
   msg = UserMailer.activation_email(user)
   msg.deliver!
  end

end
