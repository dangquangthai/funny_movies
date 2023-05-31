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
end
