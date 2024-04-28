import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sliding-menu"
export default class extends Controller {
  static targets = ['menu', 'menuContainer']

  toggleMenu() {
    this.menuTarget.classList.toggle('-left-full');
    this.menuTarget.classList.toggle('left-0');
  }

  connect() {
    document.addEventListener('click', (event) => {
      const clickOutside = !this.menuContainerTarget.contains(event.target);
      if (clickOutside && this.menuTarget.classList.contains('left-0')) {
        this.toggleMenu()
      }
    });
  }
}
