require 'rails_helper'

RSpec.describe Integration::Youtube, type: :service do
  subject { Integration::Youtube.new(source_id: youtube_id) }

  describe '#fetch' do
    context 'youtube_id is blank' do
      let(:youtube_id) { nil }

      it 'does not set title or description' do
        subject.fetch

        expect(subject.title).to be_nil
        expect(subject.description).to be_nil
      end
    end

    context 'youtube_id is not blank' do
      context 'youtube_id is not a valid YouTube ID' do
        let(:youtube_id) { 'invalid' }

        it 'does not set title or description' do
          subject.fetch

          expect(subject.title).to be_empty
          expect(subject.description).to be_present
        end
      end

      context 'youtube_id is a valid YouTube ID' do
        let(:youtube_id) { 'rKtzj_9vl8Q' }

        it 'sets title and description' do
          subject.fetch

          expect(subject.title).to eq('The Flood (Full Episode) | SPECIAL')
          expect(subject.description).to include("Each year, the arrival of a miracle flood transforms a desert into a water wonderland")
        end
      end
    end
  end
end
