class ProfilesController < ApplicationController
  def show

    Rails.logger.debug "Profile show action called with id: #{params[:id]}"
    @artwork = Artwork.find(params[:id])
    Rails.logger.debug "Artwork found: #{@artwork.inspect}"
    @artist_name = @artwork.artist_name
    @artworks = Artwork.where(artist_name: @artist_name).with_attached_images
    Rails.logger.debug "Artworks found: #{@artworks.count}"
  end
end
