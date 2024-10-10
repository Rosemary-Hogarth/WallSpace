import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    console.log("Image preview controller connected")
  }

  preview() {
    this.previewTarget.innerHTML = ''

    for (const file of this.inputTarget.files) {
      const reader = new FileReader()
      reader.onload = (e) => {
        const img = document.createElement('img')
        img.src = e.target.result
        img.width = 100
        img.height = 100
        img.style.margin = '5px'
        this.previewTarget.appendChild(img)
      }
      reader.readAsDataURL(file)
    }
  }

}
