class UsersController < ApplicationController

  def index
    render :index
  end

  def create
    if @user = User.new(params[:user])
      flash[:notices] = ["User updated"]
      redirect_to user(@user)
    else
      flash.now[:notices] = @user.errors
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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notices] = ["User updated"]
      redirect_to user(@user)
    else
      flash.now[:notices] = @user.errors
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

end
