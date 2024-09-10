# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AfCore::TomorrowIoService do
  let(:latitude) { 42.3478 }
  let(:longitude) { -71.0466 }
  let(:subject) { described_class.new(latitude, longitude) }

  context '#CONSTANTS' do
    it 'should define CACHE_DURATION' do
      expect(described_class.const_defined?(:CACHE_DURATION)).to eq(true)
      expect(described_class::CACHE_DURATION).to eq(30.minutes)
    end

    it 'should define IP_SERVICE_URL' do
      expect(described_class.const_defined?(:IP_SERVICE_URL)).to eq(true)
      expect(described_class::IP_SERVICE_URL).to eq('https://api.tomorrow.io/v4')
    end
  end

  context '#call' do
    it 'should call using cache' do
      expect(AfCore::CacheManager).to receive(:cached).once.and_call_original
      expect(subject).to receive(:query)

      subject.call
    end
  end
end
