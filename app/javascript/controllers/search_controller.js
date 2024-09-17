import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "clear"]
  connect() {
    this.updateClearButtonVisibility()
  }

  clear() {
    this.inputTarget.value = ''
    this.inputTarget.focus()
    this.updateClearButtonVisibility()
  }

  updateClearButtonVisibility() {
    this.clearTarget.style.display = this.inputTarget.value ? 'block' : 'none'
  }
}
