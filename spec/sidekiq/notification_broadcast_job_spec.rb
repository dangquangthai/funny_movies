require 'rails_helper'

RSpec.describe NotificationBroadcastJob, type: :job do
  fixtures :notifications

  describe '#perform' do
    it 'should broadcast a notification' do
      notification = notifications(:notify_to_john)

      expect(ActionCable.server).to receive(:broadcast).with('notification', notification.broadcast_message)

      described_class.new.perform(notification.id)
    end
  end
end
