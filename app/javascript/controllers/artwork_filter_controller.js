import { Controller } from "@hotwired/stimulus"

// Define the ArtworkFilterController class, extending the base Controller class provided by Stimulus
export default class extends Controller {
  // Define targets that we'll interact with in the DOM
  static targets = ["filter", "artworkInfo", "groupHeader"]

  // This method is called when the controller is connected to the DOM
  connect() {
    console.log("hello from controller");
    // Show all artwork information and hide group headers when the page loads
    this.showAllInfo();
  }

  // This method is called when a filter is clicked
  toggleInfo(event) {
    event.preventDefault();
    const filter = event.currentTarget.dataset.filter.toLowerCase();
    console.log(`Filter clicked: ${filter}`);

    if (filter === "all") {
      console.log("Showing all artwork information.");
      this.showAllInfo();
    } else {
      this.artworkInfoTargets.forEach(info => {
        const medium = info.dataset.medium;
        const artist = info.dataset.artist;
        console.log(`Artwork Medium: ${medium}, Artist: ${artist}`);
        if (medium === filter || artist === filter) {
          console.log("Showing artwork info.");
          info.classList.remove("hidden");
        } else {
          console.log("Hiding artwork info.");
          info.classList.add("hidden");
        }
      });
    }

    this.updateActiveFilter(event.currentTarget);
    this.toggleGroupHeaders(filter);
  }

  // Method to show all artwork information and hide group headers
  showAllInfo() {
    console.log("Executing showAllInfo()");
    // Remove 'hidden' class from all artwork info elements
    this.artworkInfoTargets.forEach(info => {
      console.log("Showing artwork info.");
      info.classList.remove("hidden");
    });
    // Add 'hidden' class to all group header elements to hide them
    this.groupHeaderTargets.forEach(header => {
      console.log("Hiding group header.");
      header.classList.add("hidden");
    });
  }

  // Method to hide all artwork information
  hideAllInfo() {
    console.log("Executing hideAllInfo()");
    // Add 'hidden' class to all artwork info elements
    this.artworkInfoTargets.forEach(info => {
      console.log("Hiding artwork info.");
      info.classList.add("hidden");
    });
  }

  // Method to update which filter button appears active
  updateActiveFilter(clickedFilter) {
    console.log("Updating active filter.");
    // Remove 'active' class from all filter elements
    this.filterTargets.forEach(filter => {
      console.log("Removing active class from filter.");
      filter.classList.remove("active");
    });
    // Add 'active' class to the clicked filter to highlight it
    console.log("Adding active class to clicked filter.");
    clickedFilter.classList.add("active");
  }

  // Method to toggle visibility of group headers based on the filter
  toggleGroupHeaders(filter) {
    console.log(`Toggling group headers for filter: ${filter}`);
    this.groupHeaderTargets.forEach(header => {
      // Toggle 'hidden' class on headers. Headers are hidden when "All" is selected, shown otherwise
      console.log(`Toggling hidden class on header: ${header}`);
      header.classList.toggle("hidden", filter === "all");
    });
  }
}
