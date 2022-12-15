import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-location"
export default class extends Controller {
  static values = {
    productId: Number
  }

  connect() {
    function getLocation() {
      if (navigator.geolocation) {
        this.userGeo = navigator.geolocation.getCurrentPosition(showPosition);
      } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
      }
    }
  }

  call_api() {
    fetch(`products/${this.productIdValue}`)
  }
}
