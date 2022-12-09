import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itineraries-index"
export default class extends Controller {
  connect() {
  }
  static targets = ["name", "form", "info"]

  update(event){
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.infoTarget.outerHTML = data
      })
  }

  displayForm(){
    this.nameTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

 }
