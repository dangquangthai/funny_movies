import { Controller } from "@hotwired/stimulus"

export default class NotificationsController extends Controller {
  connect() {
    addEventListener('remitano.onNotificationComming', this.onNotificationComming.bind(this));
  }

  onNotificationComming(event) {
    const _message = event.detail;

    fetch(this.element.dataset.src, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    }).then(r => r.text()).then(html => Turbo.renderStreamMessage(html));
  }
}
