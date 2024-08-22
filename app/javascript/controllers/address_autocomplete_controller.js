import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { url: String }
  static targets = ["address"]

  connect() {
    this.inputElement = this.addressTarget
    this.createAutocomplete()
  }

  createAutocomplete() {
    this.inputElement.addEventListener('input', (event) => {
      const query = event.target.value
      if (query.length < 3) return

      const apiUrl = `${this.urlValue}${encodeURIComponent(query)}&limit=5`
      fetch(apiUrl)
        .then(response => response.json())
        .then(data => this.updateSuggestions(data))
    })
  }

  updateSuggestions(data) {
    this.clearSuggestions()

    const suggestionsContainer = document.createElement('div')
    suggestionsContainer.classList.add('autocomplete-suggestions')

    data.features.forEach((feature) => {
      const suggestionItem = document.createElement('div')
      suggestionItem.classList.add('autocomplete-suggestion')
      suggestionItem.textContent = feature.properties.label
      suggestionItem.addEventListener('click', () => this.selectSuggestion(feature))

      suggestionsContainer.appendChild(suggestionItem)
    })

    this.inputElement.parentNode.appendChild(suggestionsContainer)
  }

  selectSuggestion(feature) {
    this.inputElement.value = feature.properties.label
    this.clearSuggestions()
  }

  clearSuggestions() {
    const existingSuggestions = this.inputElement.parentNode.querySelector('.autocomplete-suggestions')
    if (existingSuggestions) {
      existingSuggestions.remove()
    }
  }

  disconnect() {
    this.clearSuggestions()
  }
}
