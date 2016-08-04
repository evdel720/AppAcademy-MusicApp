class BandsController < ApplicationController
  before_action :current_band, only: [:show, :edit, :update, :destroy]

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notice] = "New band #{@band.name} is successfully registered."
      redirect_to bands_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @band.update(band_params)
      flash[:notice] = "#{@band.name} is successfully updated."
      redirect_to band_url(@band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band.destroy
    flash[:notice] = "#{@band.name} is successfully deleted."
    redirect_to bands_url
  end

  private

  def current_band
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      flash[:errors] ||= []
      flash[:errors] << "This band doesn't exist."
      redirect_to bands_url
    else
      @band
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
