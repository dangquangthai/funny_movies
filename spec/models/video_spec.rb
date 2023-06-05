require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.validations' do
    it { should validate_inclusion_of(:source).in_array(%w[youtube vimeo]) }
    it { should validate_uniqueness_of(:source_id).scoped_to(%i[source user_id]) }

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

  describe '.callbacks' do
    describe 'after_create' do
      it 'should create a notification' do
        video = build(:video)

        expect { video.save }.to change(SharedVideoJob.jobs, :size).by(1)
      end
    end
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
    let(:video) { build(:video, source_url: source_url) }

    context 'source_url is not a YouTube URL' do
      let(:source_url) { 'https://youtube.com/watch?v=' }

      it 'does not set source_id, title or description' do
        video.fetch_youtube_metadata

        expect(video.errors[:source_url]).to include('must be a YouTube URL')
      end
    end

    context 'source_url is a YouTube URL' do
      let(:source_url) { 'https://youtube.com/watch?v=eZ2Rt2DVGdU' }

      context 'going well' do
        context 'and returns false' do
          before do
            expect(Integration::Youtube).to receive(:new)
              .with(source_url: source_url)
              .and_return(instance_double(Integration::Youtube, perform: false))
          end

          it 'adds error to source_url' do
            video.fetch_youtube_metadata

            expect(video.errors[:source_url]).to include('is not a valid YouTube URL')
          end
        end

        context 'and returns true' do
          before do
            expect(Integration::Youtube).to receive(:new)
              .with(source_url: source_url)
              .and_return(
                instance_double(
                  Integration::Youtube,
                  perform: true,
                  title: 'Remitano test Ruby on Rails',
                  description: 'Description for Remitano test Ruby on Rails',
                  source_id: 'eZ2Rt2DVGdU'
                )
              )
          end

          it 'sets source_id, title and description to correct value' do
            video.fetch_youtube_metadata

            expect(video.source_id).to eq('eZ2Rt2DVGdU')
            expect(video.title).to eq('Remitano test Ruby on Rails')
            expect(video.description).to eq('Description for Remitano test Ruby on Rails')
          end
        end
      end

      context 'service raises error' do
        before do
          expect(Integration::Youtube).to receive(:new)
            .with(source_url: source_url)
            .and_raise(StandardError)
        end

        it 'adds error to source_url' do
          video.fetch_youtube_metadata

          expect(video.errors[:source_url]).to include('is not a valid YouTube URL')
        end
      end
    end
  end
end
