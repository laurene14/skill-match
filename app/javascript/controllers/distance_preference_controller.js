import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance-preference"
export default class extends Controller {
  static targets = ["output"]

  connect() {
  }

  distance(event) {
    // console.log(event.currentTarget.value)
    this.outputTarget.innerText = event.currentTarget.value
  }
}
