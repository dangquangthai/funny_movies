import { Controller } from "@hotwired/stimulus"

export default class NotificationController extends Controller {
  connect() {
    setTimeout(() => { this.close(); }, 20 * 1000);
  }

  onClose(e) {
    e.preventDefault();
    this.close();
  }

  close() {
    this.element.remove();
  }
}
