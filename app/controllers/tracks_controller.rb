class TracksController < ApplicationController
  before_action :current_track, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notice] = "New track #{@track.title} is successfully registered."
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @track.update(track_params)
      flash[:notice] = "#{@track.title} is successfully updated."
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track.destroy
    flash[:notice] = "#{@track.title} is successfully deleted."
    redirect_to bands_url
  end

  private

  def current_track
    @track = Track.find_by(id: params[:id])
    if @track.nil?
      flash[:errors] ||= []
      flash[:errors] << "This track doesn't exist."
      redirect_to bands_url
    else
      @track
    end
  end

  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end
end
