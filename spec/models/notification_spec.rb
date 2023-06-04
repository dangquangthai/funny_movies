require 'rails_helper'

RSpec.describe Notification, type: :model do
  fixtures :notifications

  describe '.validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notifiable) }
    it { should validate_presence_of(:whodunit) }
    it { should validate_presence_of(:action) }
  end

  describe '.associations' do
    it { should belong_to(:user) }
    it { should belong_to(:notifiable) }
  end

  describe '.callbacks' do
    describe 'after_create' do
      it 'should create a notification' do
        notification = build(:notification)

        expect { notification.save }.to change(NotificationBroadcastJob.jobs, :size).by(1)
      end
    end
  end

  describe '#broadcast_message' do
    it 'returns a message' do
      notification = build_stubbed(:notification, id: 1, user_id: 2)

      expect(notification.broadcast_message).to eq({ id: 1, type: 'notification', user_id: '2' })
    end
  end

  describe '#to_flash_message' do
    it 'returns a message' do
      notification = build_stubbed(:notification)

      expect(notification.to_flash_message).to eq("#{notification.whodunit.email} shared <strong>#{notification.title}</strong> video with you")
    end
  end

  describe '#mark_as_notified!' do
    let(:notification) { notifications(:notify_to_john) }

    before do
      expect(notification.notified_at).to be_nil
    end

    it 'updates notified_at attribute' do
      expect { notification.mark_as_notified! }.to change { notification.notified_at }
    end
  end
end
