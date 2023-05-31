require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.validations' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:source) }
    it { should validate_inclusion_of(:source).in_array(Video::SOURCES) }
    
    it { should validate_presence_of(:source_id) }
  end

  describe '.associations' do
    it { should belong_to(:user) }

    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:dislikes).dependent(:destroy) }
  end

  describe '#youtube?' do
    context 'source is youtube' do
      it 'returns true' do
        video = build_stubbed(:video, :youtube)
        expect(video.youtube?).to be true
      end
    end
      
    context 'source is not youtube' do
      it 'returns false' do
        video = build_stubbed(:video, :vimeo)
        expect(video.youtube?).to be false
      end
    end
  end

  describe '#vimeo?' do
    context 'source is vimeo' do
      it 'returns true' do
        video = build_stubbed(:video, :vimeo)
        expect(video.vimeo?).to be true
      end
    end
      
    context 'source is not vimeo' do
      it 'returns false' do
        video = build_stubbed(:video, :youtube)
        expect(video.vimeo?).to be false
      end
    end
  end
end
