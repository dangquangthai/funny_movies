require 'rails_helper'

RSpec.describe "Engagements::UserLoggedStates", type: :request do
  fixtures :users

  describe "GET /index" do
    context 'when user is logged in' do
      before do
        sign_in users(:john)
      end

      it "returns Engagements::UserLoggedInComponent" do
        expect(Engagements::UserLoggedInComponent).to receive(:new).and_call_original

        get engagements_user_logged_state_path

        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it "returns Engagements::UserLoggedOutComponent" do
        expect(Engagements::UserLoggedOutComponent).to receive(:new).and_call_original

        get engagements_user_logged_state_path

        expect(response).to have_http_status(:success)
      end
    end
  end
end
