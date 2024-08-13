class ProfilesController < ApplicationController
  def show
    # Log the incoming parameters for debugging purposes
    Rails.logger.debug "Params: #{params.inspect}"

    # Check if an artwork_id was provided in the URL parameters
    if params[:artwork_id].present?
      # Try to find the artwork in the database using the provided ID
      @artwork = Artwork.find_by(id: params[:artwork_id])

      # Log whether the artwork was found (for debugging)
      Rails.logger.debug "Artwork found: #{@artwork.inspect}"

      # If no artwork was found with the given ID
      if @artwork.nil?
        # Set a flash message to inform the user
        flash[:alert] = "Artwork not found"
        # Redirect to the homepage and stop further execution of this action
        redirect_to root_path and return
      end
    else
      # If no artwork_id was provided in the URL
      flash[:alert] = "No artwork specified"
      # Redirect to the homepage and stop further execution of this action
      redirect_to root_path and return
    end

    # If we've reached this point, we have a valid @artwork

    # Find all artworks by the same artist
    # This creates a collection of artworks with the same artist_name
    @artworks = Artwork.where(artist_name: @artwork.artist_name)

    # At this point, the action will render the show.html.erb view
    # The view can use @artwork for the current artwork's details
    # and @artworks for displaying all artworks by the same artist
  end
end
