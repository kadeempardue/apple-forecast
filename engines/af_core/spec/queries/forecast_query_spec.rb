require "rails_helper"

RSpec.describe AfCore::ForecastQuery do
  let(:location_data) { file_fixture("ipinfo1.json") }
  let(:timeline_data) { file_fixture("timeline1.json") }
  let!(:stub_forecast) do
    stub_request(:get,
      'https://api.geoapify.com/v1/ipinfo?apiKey='
    ).to_return(status: 200, body: location_data, headers: {})
  end
  let!(:stub_forecast2) do
    stub_request(:get,
      'https://api.tomorrow.io/v4/weather/forecast?apikey=&location=33.8266,-84.6007&units=imperial'
    ).to_return(status: 200, body: timeline_data, headers: {})
  end

  before do
    allow_any_instance_of(AfCore::GeocoderService).to receive(:call).and_return('30168')
  end

  context '#CONSTANTS' do
    it 'should define CACHE_DURATION' do
      expect(described_class.const_defined?(:CACHE_DURATION)).to eq(true)
      expect(described_class::CACHE_DURATION).to eq(30.minutes)
    end
  end

  context '#perform' do
    it 'should return a new forecast' do
      result = subject.perform
      expect(result).to be_a_kind_of(AfCore::Forecast)
      expect(result.location).to be_a_kind_of(AfCore::Location)
      expect(result.daily_timelines.count).to eq(7)
      expect(result.daily_timelines.map(&:class).uniq.first).to eq(AfCore::Timeline)
      expect(result.hourly_timelines.count).to eq(120)
      expect(result.hourly_timelines.map(&:class).uniq.first).to eq(AfCore::Timeline)
      expect(result.minutely_timelines.count).to eq(60)
      expect(result.minutely_timelines.map(&:class).uniq.first).to eq(AfCore::Timeline)
    end
  end
end