require 'rails_helper'

RSpec.describe "MyTests", type: :request do
  describe "GET /hello" do
    it "returns http success" do
      get "/my_test/hello"
      expect(response).to have_http_status(:success)
    end
  end
end