import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interaction"
export default class extends Controller {
  connect() {
  }

  clickAccept(event) {
    this.handleClickStatusButton(event, 1);
    event.preventDefault();
  }

  clickRefuse(event) {
    this.handleClickStatusButton(event, 2)
    event.preventDefault();
  }

  handleClickStatusButton(event, status) {
    if (status === 1) {
      this.handleAccept(activeCards[0]);
    } else if (status === 2) {
      this.handleRefuse(activeCards[0]);
    } else if (status === 3) {
      var moveOutHeight = document.body.clientHeight;
      card.style.transform = 'translateY(-' + moveOutHeight + 'px)';
      this.handleFollow(activeCards[0]);
    }
  }
}
