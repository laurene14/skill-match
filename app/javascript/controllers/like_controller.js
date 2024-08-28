import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  currentUserId = null;
  csrfToken = null;
  static values = { id: String }

  connect() {
    console.log("connected");
    this.currentUserId = parseInt(document.body.dataset.currentUserId, 10);
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

  toggle() {
    if (this.element.classList.contains("liked")) {
      console.log("dislike!")
      this.handleDislike();
    } else {
      console.log("relike!")
      this.handleRelike();
    }
    this.element.classList.toggle('liked')
    this.element.classList.toggle('disliked')
  }

  handleDislike() {
    const url = `/likes/${this.idValue}`;
    const verb = 'DELETE';
    const body = JSON.stringify({ "id": this.idValue })
    this.fetchData(url, verb, body)
  }

  handleRelike() {
    const url = `/likes`;

    const verb = 'POST';
    const body = JSON.stringify({
      "liker_id": this.currentUserId,
      "liked_id": this.element.id,
      "wanted": true
    })
    this.fetchData(url, verb, body)
  }

  fetchData(url, verb, body) {
    const options = {
      method: verb,
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': this.csrfToken
      },
      body: body
    }

    console.log(url, options)
    fetch(url, options)
      .then(response => {
        if (!response.ok) {
          return response.json().then(errorData => {
            throw new Error(JSON.stringify(errorData));
          });
        }
        return response.json();
      })
      .then(data => console.log('Success:', data))
      .catch(error => console.log(error))
  }
}
