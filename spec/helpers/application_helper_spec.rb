require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#material_icon' do
    it 'returns a material icon' do
      expect(helper.material_icon('add')).to eq '<span class="material-icons material-symbols-outlined">add</span>'
    end

    context 'when options are passed' do
      it 'returns a material icon with options' do
        expect(helper.material_icon('add', class: 'text-red-500')).to eq '<span class="text-red-500 material-icons material-symbols-outlined">add</span>'
      end
    end
  end

  describe '#turbo_redirect_tag' do
    it 'returns a turbo redirect tag' do
      expect(helper.turbo_redirect_tag('https://example.com')).to eq '<turbo-stream action="replace" target="redirect-tag"><template><div data-controller="redirect" data-url="https://example.com"></div></template></turbo-stream>'
    end
  end
end
