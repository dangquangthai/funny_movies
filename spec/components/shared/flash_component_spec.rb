# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shared::FlashComponent, type: :component do
  describe '#render_inline' do
    it 'renders a notice flash' do
      render_inline described_class.new(type: 'notice', message: 'Signed in successfully.')

      expect(page).to have_selector '.bg-green-300.text-green-900', text: 'Signed in successfully.'
    end

    it 'renders a error flash' do
      render_inline described_class.new(type: 'error', message: 'Share a video failed.')

      expect(page).to have_selector '.bg-red-300.text-red-900', text: 'Share a video failed.'
    end

    it 'renders a alert flash' do
      render_inline described_class.new(type: 'alert', message: 'You should add spec to the right place.')

      expect(page).to have_selector '.bg-yellow-300.text-yellow-900', text: 'You should add spec to the right place.'
    end
  end
end
