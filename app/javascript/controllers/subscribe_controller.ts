import { Controller } from "@hotwired/stimulus";
import consumer from '../channels/consumer';

export default class SubscribeController extends Controller {
  connect() {
    consumer.subscriptions.create('NotificationChannel', {
      received(message) {
        const eventData = { bubbles: true, detail: message }
        dispatchEvent(new CustomEvent('remitano.notification', eventData));
      }
    });

    addEventListener('remitano.notification', this.onReceived.bind(this));
    this.fetchNotifications();
  }

  onReceived(event) {
    const message = event.detail;

    if (message.user_id !== this.element.dataset.userId) {
      return;
    }

    switch (message.type) {
      case 'notification':
        this.fetchNotifications();
        break;
      case 'something':
        console.log('something is not supported yet');
        break;
    }
  }

  fetchNotifications() {
    fetch(document.getElementById('notification-tag').dataset.src, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    }).then(r => r.text()).then(html => Turbo.renderStreamMessage(html));
  }
}
