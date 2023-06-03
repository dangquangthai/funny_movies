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
      it { should allow_values('https://youtu.be/eZ2Rt2DVGdU').for(:source_url) }
      it { should_not allow_values('http://example.com', 'https://youtube1.com').for(:source_url).with_message('must be a YouTube URL') }
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

  describe '#fetch_youtube_metadata' do
    context 'source_url is blank' do
      it 'does not set source_id' do
        video = build_stubbed(:video, source_url: nil)
        video.fetch_youtube_metadata
        expect(video.source_id).to be_nil
      end
    end

    context 'source_url is not blank' do
      context 'source_url is not a YouTube URL' do
        it 'sets source_id to nil' do
          video = build_stubbed(:video, source_url: 'http://example.com')
          video.fetch_youtube_metadata
          expect(video.source_id).to be_nil
        end
      end

      context 'source_url is a YouTube URL' do
        context 'service going well' do
          before do
            expect(Integration::Youtube).to receive(:new)
              .with(source_id: 'eZ2Rt2DVGdU')
              .and_return(
                instance_double(
                  Integration::Youtube,
                  fetch: true,
                  title: 'Remitano test Ruby on Rails',
                  description: 'Description for Remitano test Ruby on Rails'
                )
              )
          end

          it 'sets source_id, title and description to correct value' do
            video = build_stubbed(:video, source_url: 'https://youtube.com/watch?v=eZ2Rt2DVGdU')
            video.fetch_youtube_metadata

            expect(video.source_id).to eq('eZ2Rt2DVGdU')
            expect(video.title).to eq('Remitano test Ruby on Rails')
            expect(video.description).to eq('Description for Remitano test Ruby on Rails')
          end
        end

        context 'service raises error' do
          before do
            expect(Integration::Youtube).to receive(:new)
              .with(source_id: 'eZ2Rt2DVGdU')
              .and_raise(StandardError)
          end

          it 'adds error to source_url' do
            video = build_stubbed(:video, source_url: 'https://youtube.com/watch?v=eZ2Rt2DVGdU')
            video.fetch_youtube_metadata

            expect(video.errors[:source_url]).to include('is not a valid YouTube URL')
          end
        end
      end
    end
  end
end
