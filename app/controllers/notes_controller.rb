class NotesController < ApplicationController

  before_filter :require_login
  before_filter :require_ownership, :only => [:destroy]

  def create
    @note = Note.new(params[:note])
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    if @note.save
      flash[:notices] = ["Note Created"]
      redirect_to track_url(params[:track_id])
    else
      flash[:notices] = @note.errors.full_messages
      redirect_to track_url(params[:track_id])
    end
  end

  def destroy
    @note.destroy
    redirect_to track_url(params[:track_id])
  end

  private

  def require_ownership
    @note = Note.find(params[:id])
    unless current_user.id == @note.user_id
      flash[:notices] = ["You must own a note to delete it"]
      redirect_to track_url[params[:track_id]]
    end
  end

end