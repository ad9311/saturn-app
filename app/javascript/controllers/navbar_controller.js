import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['menu']

  toggleMenu() {
    this.menuTarget.classList.toggle('-left-full');
    this.menuTarget.classList.toggle('left-0');
  }
}
