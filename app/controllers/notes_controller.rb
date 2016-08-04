class NotesController < ApplicationController
  before_action :require_login
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @track = Track.find_by(id: params[:track_id])
    @note.track_id = @track.id
    if @note.save
      flash[:notice] = "You left a note on this track."
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @note.errors.full_messages
      render "tracks/show"
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note.user_id == current_user.id
      @note.destroy
      redirect_to track_url(@note.track)
    else
      render :text => "You can't delete note if it's not yours.", :status => :unprocessable_entity
    end
  end

  private
  def note_params
    params.require(:note).permit(:body)
  end
end
