import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-bottom"
export default class extends Controller {
  links = [
    {icon_inactive: "icons/home-empty.png", icon_active: "icons/home-full.png", key: "categories"},
    {icon_inactive: "icons/card-empty.png", icon_active: "icons/card-full.png", key: "users"},
    {icon_inactive: "icons/reverse.png", icon_active: "icons/reverse.png", key: "likes"},
    {icon_inactive: "icons/chat-empty.png", icon_active: "icons/chat-full.png", key: "matchs"},
    {icon_inactive: "icons/notif-empty.png", icon_active: "icons/notif-full.png", key: "notifications"},
  ]
  static targets = ["bottom"];

  connect() {
    console.log("c'est bon")
    const path = window.location.pathname
    this.bottomTargets.forEach((bottom, i) => {
      if (path.includes(this.links[i].key)) {
        bottom.src = this.links[i].icon_active
      }
      else {
        bottom.src = this.links[i].icon_inactive
      }
    })

  }


}
