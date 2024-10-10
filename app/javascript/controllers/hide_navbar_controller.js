import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log('navbar controller connected')
    console.log('current path:', window.location.pathname)
    this.checkNavbarVisibility()
    }


  checkNavbarVisibility() {
    if (this.shouldHideNavbar()) {
      this.hideNavbar();
    } else {
      console.log('should show navbar')
    }

  }
  shouldHideNavbar() {
    return window.location.pathname.startsWith('/artworks/')
  }

  hideNavbar() {
    const navbar = this.element;
    if (navbar) {
      navbar.style.display = "none";
    } else {
      console.log('Navbar element not found');
    }
  }
}
