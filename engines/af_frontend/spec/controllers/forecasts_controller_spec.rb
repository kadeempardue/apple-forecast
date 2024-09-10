# frozen_string_literal: true

RSpec.describe AfFrontend::ForecastsController, type: :controller do
  routes { AfFrontend::Engine.routes }

  describe 'GET index' do
    let(:location_data) { file_fixture('ipinfo1.json') }
    let(:timeline_data) { file_fixture('timeline1.json') }
    let(:stub_url1) { 'https://api.geoapify.com/v1/ipinfo?apiKey=' }
    let!(:stub_forecast) { stub_request(:get, stub_url1).to_return(status: 200, body: location_data, headers: {}) }
    let(:stub_url2) { 'https://api.tomorrow.io/v4/weather/forecast?apikey=&location=33.8266,-84.6007&units=imperial' }
    let!(:stub_forecast2) { stub_request(:get, stub_url2).to_return(status: 200, body: timeline_data, headers: {}) }

    before do
      allow_any_instance_of(AfCore::GeocoderService).to receive(:call).and_return('30168')
      get :index, params: { format: :html }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'assigns instance variables' do
      expect(assigns(:forecast)).to be_a_new(AfCore::Forecast)
      expect(assigns(:current_timeline)).to be_a_new(AfCore::Timeline)
      expect(assigns(:cache_hit)).to be_nil
    end

    context 'when subsequent request is sent' do
      before { get :index, params: { format: :html } }

      it 'assigns a cache hit' do
        expect(assigns(:forecast)).to be_a_new(AfCore::Forecast)
        expect(assigns(:current_timeline)).to be_a_new(AfCore::Timeline)
        expect(assigns(:cache_hit)).to be_a_kind_of(Integer)
      end
    end
  end
end
