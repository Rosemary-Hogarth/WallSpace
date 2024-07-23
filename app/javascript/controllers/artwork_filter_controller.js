import { Controller } from "@hotwired/stimulus"

// Define the ArtworkFilterController class, extending the base Controller class provided by Stimulus
export default class extends Controller {
  // Define targets that we'll interact with in the DOM
  static targets = ["filter", "artworkInfo", "groupHeader"]

  // This method is called when the controller is connected to the DOM
  connect() {
    console.log("hello from controller")
    // Show all artwork information and hide group headers when the page loads
    this.showAllInfo()
  }

  // This method is called when a filter is clicked
  toggleInfo(event) {
    // Prevent the default link behavior (navigation)
    event.preventDefault()

    // Get the filter type from the clicked element's data attribute
    const filter = event.currentTarget.dataset.filter

    // If "All" is selected, show all artwork information, otherwise hide it
    if (filter === "all") {
      this.showAllInfo()
    } else {
      this.hideAllInfo()
    }

    // Update which filter button appears active
    this.updateActiveFilter(event.currentTarget)

    // Toggle visibility of group headers based on the filter
    this.toggleGroupHeaders(filter)
  }

  // Method to show all artwork information and hide group headers
  showAllInfo() {
    // Remove 'hidden' class from all artwork info elements
    this.artworkInfoTargets.forEach(info => info.classList.remove("hidden"))
    // Add 'hidden' class to all group header elements to hide them
    this.groupHeaderTargets.forEach(header => header.classList.add("hidden"))
  }

  // Method to hide all artwork information
  hideAllInfo() {
    // Add 'hidden' class to all artwork info elements
    this.artworkInfoTargets.forEach(info => info.classList.add("hidden"))
  }

  // Method to update which filter button appears active
  updateActiveFilter(clickedFilter) {
    // Remove 'active' class from all filter elements
    this.filterTargets.forEach(filter => filter.classList.remove("active"))
    // Add 'active' class to the clicked filter to highlight it
    clickedFilter.classList.add("active")
  }

  // Method to toggle visibility of group headers based on the filter
  toggleGroupHeaders(filter) {
    this.groupHeaderTargets.forEach(header => {
      // Toggle 'hidden' class on headers. Headers are hidden when "All" is selected, shown otherwise
      header.classList.toggle("hidden", filter === "all")
    })
  }
}
