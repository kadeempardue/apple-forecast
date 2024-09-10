# frozen_string_literal: true

RSpec.describe AfRestApi::V1::Core::ErrorsController, type: :controller  do
  routes { AfRestApi::Engine.routes }

  describe "GET not_found" do
    before { get :not_found, params: { not_found: :some_path, format: :json } }

    it "has a 404 status code" do
      expect(response.status).to eq(404)
    end

    it "returns the correct JSON response" do
      expect(response.body).to eq({ errors: [{ path: :some_path }] }.to_json)
    end
  end
end