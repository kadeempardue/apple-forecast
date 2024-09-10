require "rails_helper"

RSpec.describe AfCore::GeocoderService do
  let(:latitude) { 42.3478 }
  let(:longitude) { -71.0466 }
  let(:subject) { described_class.new(latitude, longitude) }

  context '#CONSTANTS' do
    it 'should define CACHE_DURATION' do
      expect(described_class.const_defined?(:CACHE_DURATION)).to eq(true)
      expect(described_class::CACHE_DURATION).to eq(1.month)
    end
  end

  context '#call' do
    it 'should call using cache' do
      expect(Geocoder).to receive(:search).once.and_return([OpenStruct.new(postal_code: 30168)])
      expect(AfCore::CacheManager).to receive(:cached).once.and_call_original
      expect(subject).to receive(:search_postal_code).and_call_original
      subject.call
    end
  end
end