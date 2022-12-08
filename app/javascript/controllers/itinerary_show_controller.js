import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itinerary-show"
export default class extends Controller {
  connect() {
  }
  static targets = ["newNameForm", "nameContainer", "name", "itineraryId", "date", "dateForm", "datePencil", "savedItineraryId"]

  updateDate(event){
    event.preventDefault()
    const url = `/my_itineraries/${this.savedItineraryIdTarget.value}/update/date`
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.dateFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.dateTarget.outerHTML = data
      })
      this.dateFormTarget.classList.add("d-none")
      this.datePencilTarget.classList.remove("d-none")
  }

  updateName(event){
    event.preventDefault()
    const url = `/my_itineraries/${this.itineraryIdTarget.value}/update/name`
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.newNameFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.nameTarget.outerHTML = data
      })
      this.newNameFormTarget.classList.add("d-none")

  }

  displayNewNameForm(){
    this.nameTarget.classList.add("d-none")
    this.newNameFormTarget.classList.remove("d-none")
  }

  displayDateForm(){
    this.dateTarget.classList.add("d-none")
    this.datePencilTarget.classList.add("d-none")
    this.dateFormTarget.classList.remove("d-none")
  }
}
