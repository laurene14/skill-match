import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance-preference"
export default class extends Controller {
  connect() {
    console.log("c'est connecté - Laurène")
  }
}
