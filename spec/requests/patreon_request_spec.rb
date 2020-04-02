require 'rails_helper'

RSpec.describe "Patreons", type: :request do

  describe "GET /authenticate" do
    it "returns http success" do
      get "/patreon/authenticate"
      expect(response).to have_http_status(:success)
    end
  end

end
