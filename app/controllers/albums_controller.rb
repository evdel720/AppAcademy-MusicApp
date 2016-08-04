class AlbumsController < ApplicationController
  before_action :current_album, only: [:show, :edit, :update, :destroy]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "New album #{@album.title} is successfully registered."
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @album.update(album_params)
      flash[:notice] = "#{@album.title} is successfully updated."
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album.destroy
    flash[:notice] = "#{@album.title} is successfully deleted."
    redirect_to bands_url
  end

  private

  def current_album
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      flash[:errors] ||= []
      flash[:errors] << "This album doesn't exist."
      redirect_to bands_url
    else
      @album
    end
  end

  def album_params
    params.require(:album).permit(:title, :band_id, :album_type)
  end
end
