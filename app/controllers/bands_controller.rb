class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      flash[:notices] = ["Band Created"]
      redirect_to band_url(@band)
    else
      flash.now[:notices] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.where(:id => params[:id]).includes(:albums => :tracks).first
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(params[:band])
      flash[:notices] = ["Band Updated"]
      redirect_to band_url(@band)
    else
      flash.now[:notices] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
  end

end