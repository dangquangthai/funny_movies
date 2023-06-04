require 'rails_helper'

RSpec.describe NotificationChannel, type: :channel do
  let(:user) { build_stubbed(:user) }

  before do
    stub_connection(current_user: user)
    subscribe
  end

  describe '#subcribed' do
    it 'subscribes the user to the channel' do
      expect(subscription).to be_confirmed
    end

    it 'opens a stream for the user' do
      expect(subscription).to have_stream_for('notification')
    end
  end

  describe '#unsubcribed' do
    it 'logs some user info' do
      subscription.unsubscribe_from_channel
    end
  end
end
