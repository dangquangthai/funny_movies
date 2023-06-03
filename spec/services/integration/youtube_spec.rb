require 'rails_helper'

RSpec.describe Integration::Youtube, type: :service do
  subject { Integration::Youtube.new(source_url: youtube_url) }

  describe '#perform' do
    context 'youtube_url is not a valid YouTube ID' do
      let(:youtube_url) { "https://www.youtube.com/watch?v=#{Faker::Alphanumeric.alphanumeric(number: 10)}" }

      it 'does not set title or description' do
        expect(subject.perform).to be false

        expect(subject.title).to be_nil
        expect(subject.description).to be_nil
      end
    end

    context 'youtube_url is a valid YouTube ID' do
      let(:youtube_url) { 'https://www.youtube.com/watch?v=rKtzj_9vl8Q' }

      it 'sets title and description' do
        expect(subject.perform).to be true

        expect(subject.title).to eq('The Flood (Full Episode) | SPECIAL')
        expect(subject.description).to include("Each year, the arrival of a miracle flood transforms a desert into a water wonderland")
      end
    end
  end
end
