class TracksController < ApplicationController
  before_filter :require_login, :except => [:show, :index]
  before_filter :require_admin, :except => [:show, :index]

  def new
    @track = Track.new(:album_id => params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(params[:track])
    if @track.save
      flash[:notices] = ["Track Created"]
      redirect_to track_url(@track)
    else
      flash.now[:notices] = @track.errors.full_messages
      render :new
    end
  end

  def index
    @tracks = Track.includes(:album => :band)
    render :index
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
    @notes = @track.notes.order(:created_at)
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(params[:track])
      flash[:notices] = ["Track Updated"]
      redirect_to track_url(@track)
    else
      flash.now[:notices] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_url
  end

end