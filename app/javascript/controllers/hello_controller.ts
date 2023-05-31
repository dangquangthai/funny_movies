import { Controller } from "@hotwired/stimulus"

export default class Hello extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }
}
