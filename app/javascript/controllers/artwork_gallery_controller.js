// app/javascript/controllers/artwork_gallery_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["largeImage", "thumbnail"]
  static values = { currentArtworkId: Number }

  connect() {
    console.log("Artwork gallery controller connected")
  }

  updateImage(event) {
    const clickedThumbnail = event.currentTarget
    const artworkId = clickedThumbnail.closest('.artwork-thumbnail').dataset.artworkId

    if (parseInt(artworkId) === this.currentArtworkIdValue) {
      // If it's the current artwork, just update the large image
      this.largeImageTarget.src = clickedThumbnail.src
      this.largeImageTarget.alt = clickedThumbnail.alt
    } else {
      // If it's a different artwork, navigate to its show page
      window.location.href = `/artworks/${artworkId}`
    }
  }
}
