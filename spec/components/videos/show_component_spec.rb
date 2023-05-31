# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Videos::ShowComponent, type: :component do
  fixtures :users
  fixtures :videos

  describe '#render_inline' do
    subject { described_class.new(video: video) }

    context 'when the video is a YouTube video' do
      let(:video) { videos(:big_game_of_thrones) }

      it 'renders the component' do
        render_inline(subject)

        expect(page).not_to have_selector('h1')
        expect(page).to have_selector('iframe[src="https://www.youtube.com/embed/HsAxx81QlwY"]')
        expect(page).to have_selector('div.text-red-600', text: 'Big Game of Thrones (Full Episode) | Savage Kingdom')
        expect(page).to have_selector('div', text: 'Shared by: john@remitano.com')
        expect(page).to have_selector('div', text: '0')
        expect(page).to have_selector('span', text: 'thumb_up')
        expect(page).to have_selector('span', text: 'thumb_down')
      end
    end

    context 'when the video is a Vimeo video' do
      let(:video) { build_stubbed(:video, :vimeo, user: users(:smith), likes_count: 3900, dislikes_count: 700) }

      it 'renders the component' do
        render_inline(subject)

        expect(page).not_to have_selector('iframe')
        expect(page).to have_selector('h1.font-bold.text-4xl', text: 'Other embedded - not implemented yet')
        expect(page).to have_selector('div.text-red-600', text: video.title)
        expect(page).to have_selector('div', text: 'Shared by: smith@remitano.com')
        expect(page).to have_selector('div', text: video.description)
        expect(page).to have_selector('div', text: '3.9 k')
        expect(page).to have_selector('span', text: 'thumb_up')
        expect(page).to have_selector('div', text: '700')
        expect(page).to have_selector('span', text: 'thumb_down')
      end
    end
  end
end
