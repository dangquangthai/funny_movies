import { Controller } from "@hotwired/stimulus";
import consumer from '../channels/consumer';
import triggerEvent from '../helpers/dom_helper';

export default class SubscribeController extends Controller {
  connect() {
    consumer.subscriptions.create('NotificationChannel', {
      received(message) {
        triggerEvent('remitano.onNotificationComming', message);
      }
    });

    addEventListener('remitano.onNotificationChannel', this.onNotificationChannel.bind(this));
    triggerEvent('remitano.onNotificationComming', { type: 'notification' });
  }

  onNotificationChannel(event) {
    const message = event.detail;

    if (message.user_id !== this.element.dataset.userId) {
      return;
    }

    switch (message.type) {
      case 'notification':
        triggerEvent('remitano.onNotificationComming', message);
        break;
      case 'something':
        triggerEvent('remitano.onSomethingHappening', message);
        break;
    }
  }
}
