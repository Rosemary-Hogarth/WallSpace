class ArtworksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :set_artwork, only: [:destroy, :show]


  def index
    @artworks = Artwork.all.with_attached_images

    # Apply search if query is present
    if params[:query].present?
      @artworks = @artworks.search_by_artist_name_title_medium(params[:query])
    end

    # Apply filter if present
    if params[:filter].present?
      @artworks = @artworks.where("LOWER(medium) = ?", params[:filter].downcase)
    end

    logger.debug "Filter applied: #{params[:filter]}"
    logger.debug "Query applied: #{params[:query]}"
    logger.debug "SQL query: #{@artworks.to_sql}"
    logger.debug "Number of artworks found: #{@artworks.count}"

    if @artworks.empty?
      flash.now[:alert] = if params[:query].present? && params[:filter].present?
                            "No artworks found matching '#{params[:query]}' in the '#{params[:filter].capitalize}' category."
                          elsif params[:query].present?
                            "No artworks found matching '#{params[:query]}'."
                          elsif params[:filter].present?
                            "No artworks found in the '#{params[:filter].capitalize}' category."
                          else
                            "No artworks found."
                          end
    end
  end




  def show
    @artwork = Artwork.with_attached_images.find(params[:id])
    @artworks = Artwork.where(artist_name: @artwork.artist_name).with_attached_images
  end

  def new
    @artwork = Artwork.new
  end

  def create
    puts "Params received: #{params.inspect}"
    puts "File params: #{params[:artwork][:images].inspect}" if params[:artwork][:images]

    @artwork = current_user.artworks.build(artwork_params)
    if @artwork.save
      if params[:artwork][:images].present?
        @artwork.images.attach(params[:artwork][:images])
      end
      puts "Artwork saved successfully. ID: #{@artwork.id}"
      redirect_to artworks_path
    else
       puts "Artwork failed to save. Errors: #{@artwork.errors.full_messages}"
      render :new
    end
  end

  def destroy
    if @artwork.destroy
      redirect_to artworks_path
    else
      redirect_to artworks_path, alert: "There was an error deleting the artwork."
    end
  end

  private

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:artist_name, :title, :medium, :price_per_month, :image, :width, :height, images: [])
  end

end
