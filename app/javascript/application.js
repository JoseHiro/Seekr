// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
// import "components/previewImageOnFileSelect"

window.addEventListener('load', function () {

  let button = document.querySelector(".mapboxgl-ctrl-geocoder--input");
  button.classList.add("special-input");
});
