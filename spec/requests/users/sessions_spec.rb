require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  fixtures :users

  describe "POST /create" do
    context 'with valid email and password' do
      before do
        expect(Engagements::UserLoggedInComponent).to receive(:new).and_call_original
      end

      it "returns correct template" do
        post '/custom/users/sign_in', params: {
          user: {
            email: 'smith@remitano.com',
            password: 'ThisIs@Very5Pass'
          }
        }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:create)
      end
    end
    
    context 'with invalid email and password' do
      before do
        expect(Engagements::UserLoggedOutComponent).to receive(:new).and_call_original
      end

      it "returns correct template" do
        post '/custom/users/sign_in', params: {
          user: {
            email: 'smith@remitano.com',
            password: 'wrong password'
          }
        }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:create)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      expect(Engagements::UserLoggedOutComponent).to receive(:new).and_call_original
    end

    it "returns correct template" do
      delete '/custom/users/sign_out'

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:destroy)
    end
  end
end
