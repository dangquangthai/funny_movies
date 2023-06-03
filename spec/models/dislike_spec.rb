require 'rails_helper'

RSpec.describe Dislike, type: :model do
  fixtures :videos

  describe '.validations' do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:dislikeable) }

    it do
      subject = create(:dislike, dislikeable: videos(:underwater_killer))
      should validate_uniqueness_of(:user_id)
        .scoped_to([:dislikeable_type, :dislikeable_id])
        .with_message('Video has already been disliked')
    end
  end

  describe '.associations' do
    it { should belong_to(:user) }

    it { should belong_to(:dislikeable) }
  end

  describe '.counter_cache #dislikes_count' do
    context 'when creating a dislike' do
      let(:video) { videos(:underwater_killer) }

      before do
        expect(video.dislikes_count).to eq(0)
      end

      it 'increments dislikes_count on video when a dislike is created' do
        expect {
          create(:dislike, dislikeable: video)
        }.to change { video.reload.dislikes_count }.by(1)
      end
    end
  end
end
