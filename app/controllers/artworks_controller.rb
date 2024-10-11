require 'net/http'
require 'uri'

class ArtworksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :set_artwork, only: [:destroy, :show]


  def index
    @artworks = Artwork.all.with_attached_images

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
    @artist = @artwork.user
    @map_image_url = generate_static_map_url(@artist.address) if @artist.address.present?
    puts "Debug: Map URL = #{@map_image_url}"
    puts "Debug: Artist address = #{@artist.address}"
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.user = current_user # Set the user to the currently logged-in user

    if @artwork.save
      redirect_to @artwork, notice: 'Artwork was successfully created.'
    else
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

  def generate_static_map_url(address)
    # Return nil if the address is blank to avoid processing empty addresses
    return nil if address.blank?

    # Encode the address to make it URL-safe
    encoded_address = URI.encode_www_form_component(address)
    # Construct the URL for Mapbox's geocoding API
    geocode_url = URI("https://api.mapbox.com/geocoding/v5/mapbox.places/#{encoded_address}.json?access_token=#{ENV['MAPBOX_API_KEY']}")

    begin
      # Make an HTTP GET request to the Mapbox geocoding API
      geocode_response = Net::HTTP.get_response(geocode_url)
      # Parse the JSON response from the API
      geocode_result = JSON.parse(geocode_response.body)

      # Check if the geocoding API found any results
      if geocode_result['features'].empty?
        puts "Debug: No features found for address: #{address}"
        return nil
      end

      # Extract the longitude and latitude from the first result
      longitude, latitude = geocode_result['features'][0]['center']

      # Construct and return the URL for a static map image
      # Parameters:
      # - streets-v11: the map style
      # - pin-s: a standard small pin marker
      # - 13: zoom level
      # - 0: rotation (0 degrees)
      # - 300x200: image dimensions
      # - @2x: retina (high DPI) image
      "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s(#{longitude},#{latitude})/#{longitude},#{latitude},13,0/300x200@2x?access_token=#{ENV['MAPBOX_API_KEY']}"
    rescue => e
      # If any error occurs during the process, log it and return nil
      puts "Debug: Error generating map URL: #{e.message}"
      nil
    end
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:artist_name, :title, :medium, :price_per_month, :image, :width, :height, images: [])
  end

end
