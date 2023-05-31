require 'rails_helper'

RSpec.describe ActionController::Base, type: :controller do
  controller do
    include Pagination

    def index
      page
      per_page
      head :ok
    end
  end

  describe '#page' do
    context 'when params[:page] is present' do
      it 'returns params[:page]' do
        get :index, params: { page: 2 }

        expect(assigns(:page)).to eq 2
      end
    end

    context 'when params[:page] is not present' do
      it 'returns 1' do
        get :index

        expect(assigns(:page)).to eq 1
      end
    end
  end

  describe '#per_page' do
    context 'when params[:per_page] is present' do
      it 'returns params[:per_page]' do
        get :index, params: { per_page: 10 }

        expect(assigns(:per_page)).to eq 10
      end
    end

    context 'when params[:per_page] is not present' do
      it 'returns 20' do
        get :index

        expect(assigns(:per_page)).to eq 20
      end
    end
  end
end
