class AlbumsController < ApplicationController
  before_filter :require_login, :except => [:show, :index]
  before_filter :require_admin, :except => [:show, :index]
  def index
    @albums = Album.order(:name).includes(:band)
    render :index
  end

  def new
    @bands = Band.order(:name)
    @album = Album.new(:band_id => params[:band_id])
    render :new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      flash[:notices] = ["Album Created"]
      redirect_to album_url(@album)
    else
      flash.now[:notices] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks
    render :show
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_parameters(params[:album])
      flash[:notices] = ["Album Updated"]
      redirect_to album_url(@album)
    else
      flash.now[:notices] = @album.errors.full_messages
      render :edit
    end
  end

end