require 'rails_helper'

RSpec.describe "AdminSessions", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/admin_sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin_sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /login" do
    it "returns http success" do
      get "/admin_sessions/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /welcome" do
    it "returns http success" do
      get "/admin_sessions/welcome"
      expect(response).to have_http_status(:success)
    end
  end

end
