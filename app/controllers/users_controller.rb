class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(params[:user])
    @user.activated = false
    if @user.save
      flash[:notices] = ["User updated"]
      login!(@user)
      redirect_to bands_url
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

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(params[:user])
  #     flash[:notices] = ["User updated"]
  #     redirect_to user(@user)
  #   else
  #     flash.now[:notices] = @user.errors
  #     render :edit
  #   end
  # end
  #
  # def edit
  #   @user = User.find(params[:id])
  #   render :edit
  # end

end
