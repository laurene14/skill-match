import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "button" ]

  connect() {
  }

  closePopup(event) {
    event.preventDefault()

    this.element.outerHTML = ""
  }
}
