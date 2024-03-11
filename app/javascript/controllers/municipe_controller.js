// app/javascript/controllers/municipes_controller.js
import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["details"]

  connect() {
    console.log("Municipes controller connected");
  }

  show(event) {
    event.preventDefault();
    const [data, status, xhr] = event.detail;
    this.detailsTarget.innerHTML = data;

    // Alternatively, if using Turbo Frames and you want to manually handle the response:
    // const url = event.target.href;
    // fetch(url, {
    //   headers: { "Accept": "text/vnd.turbo-stream.html" },
    // })
    // .then(response => response.text())
    // .then(html => Turbo.renderStreamMessage(html));
  }
}
