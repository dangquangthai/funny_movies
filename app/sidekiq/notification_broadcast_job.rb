# frozen_string_literal: true

class NotificationBroadcastJob
  include Sidekiq::Job

  def perform(notification_id)
    notification = Notification.find(notification_id)

    ActionCable.server.broadcast('notification', notification.broadcast_message)
  end
end
