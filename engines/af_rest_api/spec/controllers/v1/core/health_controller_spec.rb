# frozen_string_literal: true

RSpec.describe AfRestApi::V1::Core::HealthController, type: :controller do
  routes { AfRestApi::Engine.routes }

  describe 'GET index' do
    let(:data) do
      {
        health: :ok,
        component_name: 'api',
        component_version: 'core',
        app_version: AppleForecast::Application::VERSION
      }
    end

    before { get :index, params: { format: :json } }

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'returns the correct JSON response' do
      expect(response.body).to eq({ meta: data }.to_json)
    end
  end
end
