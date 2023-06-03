require 'rails_helper'

RSpec.describe Like, type: :model do
  fixtures :videos

  describe '.validations' do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:likeable) }

    it do
      subject = create(:like, likeable: videos(:big_game_of_thrones))
      should validate_uniqueness_of(:user_id)
        .scoped_to([:likeable_type, :likeable_id])
        .with_message('Video has already been liked')
    end
  end

  describe '.associations' do
    it { should belong_to(:user) }

    it { should belong_to(:likeable) }
  end

  describe '.counter_cache #likes_count' do
    context 'when creating a like' do
      let(:video) { videos(:underwater_killer) }

      before do
        expect(video.likes_count).to eq(0)
      end

      it 'increments likes_count on video when a like is created' do
        expect {
          create(:like, likeable: video)
        }.to change { video.reload.likes_count }.by(1)
      end
    end
  end
end
