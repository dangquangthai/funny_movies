require 'rails_helper'

RSpec.describe ActionController::Base, type: :controller do
  fixtures :users

  controller do
    include InitializeComponentContext

    def index
      respond_to do |format|
        format.json do
          render json: { current_user: Current.current_user }
        end
      end
    end
  end

  describe '#initialize_component_context' do
    let(:smith) { users(:smith) }
    let(:response_json) { JSON.parse(response.body)['current_user'] }
    
    context 'when user is logged in' do
      before do
        sign_in smith
      end

      it 'sets current_user' do
        get :index, format: :json

        expect(response_json['email']).to eq('smith@remitano.com')
      end
    end

    context 'when user is not logged in' do
      it 'does not set current_user' do
        get :index, format: :json

        expect(response_json).to be_nil
      end
    end
  end
end
