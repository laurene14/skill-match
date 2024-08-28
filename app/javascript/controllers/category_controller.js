import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category"
export default class extends Controller {
  connect() {
    const items = this.element.querySelectorAll(".category-item");
    this.initColor(items);
  }

  initColor(items) {
    items.forEach((item) => {
      const label = item.querySelector("label.form-check-label.collection_check_boxes")
      const name = label.innerText.toLowerCase();
      const color = item.querySelector("input.form-check-input.check_boxes").dataset.color;
      item.classList.add(name);
      label.classList.add(color);
    })
  }
}
