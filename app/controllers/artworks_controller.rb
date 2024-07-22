class ArtworksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @artworks = Artwork.all

    case params[:filter]
    when 'artist'
      @artworks = @artworks.group_by(&:artist_name)
    when 'medium'
      @artworks = @artworks.group_by(&:medium)
    end
  end

  def new
    @artwork = Artwork.new
  end

  def create
    puts "Params received: #{params.inspect}"
    @artwork = current_user.artworks.build(artwork_params)
    if @artwork.save
      redirect_to artworks_path, notice: 'Artwork was successfully created.'
    else
      render :new
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:artist_name, :title, :medium, :price_per_month, :image)
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You must be logged in to perform this action."
    end
  end
end
