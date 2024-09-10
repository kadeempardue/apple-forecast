# frozen_string_literal: true

RSpec.describe AfRestApi::V1::ForecastsController, type: :controller  do
  routes { AfRestApi::Engine.routes }

  describe "POST search" do
    let(:timeline_data) { file_fixture('timeline1.json') }
    let(:properties) { { hello: 'world' }.to_json }
    let!(:stub_forecast) do
      stub_request(:get,
        'https://api.tomorrow.io/v4/weather/forecast?apikey=&location=,&units=imperial'
      ).to_return(status: 200, body: timeline_data, headers: {})
    end

    before { post :search, params: { properties: properties, format: :json } }

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "assigns instance variables" do
      expect(assigns(:forecast)).to be_a_new(AfCore::Forecast)
      expect(assigns(:current_timeline)).to be_a_new(AfCore::Timeline)
      expect(assigns(:cache_hit)).to be_nil
    end

    context 'when subsequent request is sent' do
      before { post :search, params: { properties: properties, format: :json } }

      it "assigns a cache hit" do
        expect(assigns(:forecast)).to be_a_new(AfCore::Forecast)
        expect(assigns(:current_timeline)).to be_a_new(AfCore::Timeline)
        expect(assigns(:cache_hit)).to be_a_kind_of(Integer)
      end
    end
  end
end