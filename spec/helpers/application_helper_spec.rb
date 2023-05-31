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
end
