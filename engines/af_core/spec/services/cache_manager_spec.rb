# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AfCore::CacheManager do
  let(:cache) { Rails.cache }
  let(:path) { 'some_path' }
  let(:params) { { klass: klass.class.to_s.downcase } }
  let(:klass) { OpenStruct.new(cache_hit: nil) }

  context '#CONSTANTS' do
    it 'should define CACHE_DURATION' do
      expect(described_class.const_defined?(:CACHE_DURATION)).to eq(true)
      expect(described_class::CACHE_DURATION).to eq(30.minutes)
    end
  end

  context '#cached' do
    it 'should call and write to cache' do
      expect(cache).to receive(:fetch).twice
      expect(cache).to receive(:write).once
      expect(cache.redis).not_to receive(:ttl)
      subject.cached(path, params, described_class::CACHE_DURATION, klass) { '1' }
    end

    it 'should yield' do
      expect do |b|
        described_class.cached(path, params, described_class::CACHE_DURATION, klass, &b)
      end.to yield_control.once
    end

    context 'when called again' do
      it 'should read from the cache' do
        subject.cached(path, params, described_class::CACHE_DURATION, klass) { '1' }
        expect(cache).to receive(:fetch).once.and_call_original
        expect(cache).not_to receive(:write)
        expect(cache.redis).to receive(:ttl).once.and_call_original
        expect(klass.cache_hit).to eq(nil)
        resp = subject.cached(path, params, described_class::CACHE_DURATION, klass) { '2' }
        expect(resp).to eq('1')
        expect(klass.cache_hit).to eq(1800)
      end
    end
  end

  context '#delete' do
    let(:cache_key) { subject.cache_key(path, params) }

    it 'deletes from the cache' do
      expect(Rails.cache.fetch(cache_key)).to eq(nil)
      subject.cached(path, params, described_class::CACHE_DURATION, klass) { '1' }
      expect(Rails.cache.fetch(cache_key)).to eq('1')
      subject.delete(path, params)
      expect(Rails.cache.fetch(cache_key)).to eq(nil)
    end
  end
end
