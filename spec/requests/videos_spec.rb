require 'rails_helper'

RSpec.describe "Videos", type: :request do
  fixtures :videos

  describe "GET /index" do
    it "returns http success" do
      get "/videos"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)

      expect(assigns(:videos)).to match_array(videos)
      expect(assigns(:pagy)).to be_a(Pagy)
    end
  end

  describe "GET /new" do
    context 'when user is not signed in' do
      it "redirects to sign in page" do
        get "/videos/new"

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        sign_in(user)
      end

      it "returns http success" do
        get "/videos/new"

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)

        expect(assigns(:video)).to be_a(Video)
      end
    end
  end

  describe "POST /create" do
    let(:video_params) do
      { 
        video: { 
          source_url: 'https://youtube.com/watch?v=123456789', source: 'youtube'
        }
      }
    end

    context 'when user is not signed in' do
      it "redirects to sign in page" do
        post '/videos', params: video_params

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        sign_in(user)

        expect_any_instance_of(Video).to receive(:save).and_return(true)

        post '/videos', params: video_params
      end

      it "returns http success" do
        expect(assigns(:video)).to be_a(Video)

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:create)
      end
    end
  end
end
