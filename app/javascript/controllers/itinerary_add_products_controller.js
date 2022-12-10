import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itinerary-add-products"
export default class extends Controller {
  connect() {
  }

  static targets = ["productCard", "itineraryId", "cardForm", "addForm", "removeForm"]

  addProduct(event){
    event.preventDefault()
    const productId = this.productCardTarget.id
    const itineraryId = this.itineraryIdTarget.value
    const url = `/my_itineraries/product/${productId}/${itineraryId}/add`
    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.addFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.productCardTarget.outerHTML = data
      })

  }

  deleteProduct(event){
    event.preventDefault()
    const productId = this.productCardTarget.id
    const itineraryId = this.itineraryIdTarget.value
    const url = `/my_itineraries/product/${productId}/${itineraryId}/remove`
    fetch(url, {
      method: "DELETE",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.removeFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.productCardTarget.outerHTML = data
      })

  }



}
