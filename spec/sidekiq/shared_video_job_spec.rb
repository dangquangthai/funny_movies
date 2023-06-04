require 'rails_helper'

RSpec.describe SharedVideoJob, type: :job do
  fixtures :videos

  describe '#perform' do
    it 'should create a notification' do
      video = videos(:big_game_of_thrones)

      expect {
        described_class.new.perform(video.id)
      }.to change(Notification, :count).by(1)
    end
  end
end
