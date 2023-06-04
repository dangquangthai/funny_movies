require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  fixtures :users

  describe "GET /index" do
    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get '/notifications'

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is signed in' do
      let(:smith) { users(:smith)}

      before do
        sign_in smith
      end

      it 'returns http success' do
        get '/notifications'

        expect(response).to have_http_status(:success)
        expect(assigns(:notifications)).to be_present
      end
    end
  end
end
