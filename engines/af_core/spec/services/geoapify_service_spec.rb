# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AfCore::GeoapifyService do
  context '#CONSTANTS' do
    it 'should define IP_SERVICE_URL' do
      expect(described_class.const_defined?(:IP_SERVICE_URL)).to eq(true)
      expect(described_class::IP_SERVICE_URL).to eq('https://api.geoapify.com/v1')
    end
  end

  context '#ip_info' do
    it 'should call' do
      expect(subject).to receive(:query)
      subject.ip_info
    end
  end
end
