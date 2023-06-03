require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.validations' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:source) }
    it { should validate_inclusion_of(:source).in_array(Video::SOURCES) }
    
    it { should validate_presence_of(:source_id) }
    

    describe '#source_url' do
      subject { build(:video) }

      it { should validate_presence_of(:source_url) }
      it { should allow_values('https://youtube.com/watch?v=eZ2Rt2DVGdU').for(:source_url) }
      it { should_not allow_values('http://example.com', 'https://youtube1.com').for(:source_url).with_message('must be a valid YouTube URL') }
    end
  end

  describe '#source_url=' do
    context 'when source is youtube' do
      it 'sets the source_url' do
        video = described_class.new(source: 'youtube', source_url: 'https://youtube.com/watch?v=eZ2Rt2DVGdU')
        expect(video.source_id).to eq('eZ2Rt2DVGdU')
      end
    end

    context 'when source is vimeo' do
      it 'sets the source_url' do
        video = described_class.new(source: 'vimeo', source_url: 'https://vimeo.com/112866269')
        expect(video.source_id).to eq('not_implemented_yet')
      end
    end
  end

  describe '.associations' do
    it { should belong_to(:user) }

    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:dislikes).dependent(:destroy) }
  end

  describe '#youtube?' do
    context 'source is youtube' do
      it 'returns true' do
        video = build_stubbed(:video)
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
        video = build_stubbed(:video)
        expect(video.vimeo?).to be false
      end
    end
  end
end
