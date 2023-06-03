import { Controller } from "@hotwired/stimulus"

export default class RedirectController extends Controller {
  connect() {
    window.location = this.element.dataset.url;
  }
}
