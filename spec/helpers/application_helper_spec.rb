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

  describe '#turbo_notification_tag' do
    it 'returns a turbo notification tag' do
      flash[:notice] = 'Signed in successfully.'

      expect(helper.turbo_notification_tag).to eq '<turbo-stream action="append" target="notification-tag"><template>  <div data-controller="notification" class="pointer-events-auto w-full rounded-md shadow-md p-2 md:p-4 flex gap-2 items-center bg-green-300 text-green-900">
    <div class="grow">Signed in successfully.</div>
    <span class="flex-none material-icons material-symbols-outlined" data-action="click-&gt;notification#close">close</span>
  </div>

</template></turbo-stream>'
    end

    it 'returns a turbo notification tag' do
      flash[:error] = 'Share a video failed.'

      expect(helper.turbo_notification_tag).to eq '<turbo-stream action="append" target="notification-tag"><template>  <div data-controller="notification" class="pointer-events-auto w-full rounded-md shadow-md p-2 md:p-4 flex gap-2 items-center bg-red-300 text-red-900">
    <div class="grow">Share a video failed.</div>
    <span class="flex-none material-icons material-symbols-outlined" data-action="click-&gt;notification#close">close</span>
  </div>

</template></turbo-stream>'
    end

    it 'returns a turbo notification tag' do
      flash[:alert] = 'You should add spec to the right place.'

      expect(helper.turbo_notification_tag).to eq '<turbo-stream action="append" target="notification-tag"><template>  <div data-controller="notification" class="pointer-events-auto w-full rounded-md shadow-md p-2 md:p-4 flex gap-2 items-center bg-yellow-300 text-yellow-900">
    <div class="grow">You should add spec to the right place.</div>
    <span class="flex-none material-icons material-symbols-outlined" data-action="click-&gt;notification#close">close</span>
  </div>

</template></turbo-stream>'
    end
  end
end
