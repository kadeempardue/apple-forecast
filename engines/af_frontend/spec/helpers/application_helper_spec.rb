# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AfFrontend::ApplicationHelper, type: :helper do
  let(:timeline) { build(:timeline) }
  let(:location) { build(:location, city:, state:, country:) }
  let(:city) { 'Atlanta' }
  let(:state) { 'Georgia' }
  let(:country) { 'United States' }
  let(:time_now) { Timecop.freeze(Time.local(2024, 9, 9, 12, 0, 0)) }

  describe '#friendly_location' do
    it 'returns the friendly location' do
      expect(helper.friendly_location(location)).to eq('Atlanta, Georgia United States')
    end

    context 'without city' do
      let(:city) { nil }

      it 'returns the friendly location' do
        expect(helper.friendly_location(location)).to eq('Georgia United States')
      end
    end

    context 'without state' do
      let(:state) { nil }

      it 'returns the friendly location' do
        expect(helper.friendly_location(location)).to eq('Atlanta United States')
      end
    end

    context 'without city and state' do
      let(:city) { nil }
      let(:state) { nil }

      it 'returns the friendly location' do
        expect(helper.friendly_location(location)).to eq('United States')
      end
    end

    context 'without country' do
      let(:country) { nil }

      it 'returns the friendly location' do
        expect(helper.friendly_location(location)).to eq('Atlanta, Georgia')
      end
    end

    context 'without state and country' do
      let(:state) { nil }
      let(:country) { nil }

      it 'returns the friendly location' do
        expect(helper.friendly_location(location)).to eq('Atlanta')
      end
    end
  end

  describe '#friendly_day' do
    it 'returns a friendly day' do
      expect(helper.friendly_day(time_now)).to eq('Sep 09')
    end
  end

  describe '#friendly_time' do
    it 'returns a friendly time' do
      expect(helper.friendly_time(time_now)).to eq('12:00 PM EDT')
    end
  end

  describe '#friendly_weather_icon' do
    let(:image_path) { '/assets/af_frontend/tomorrow-icons/11000_mostly_clear_small' }

    it 'returns a friendly weather icon' do
      expect(helper.friendly_weather_icon(timeline)).to include(image_path)
    end
  end

  describe '#get_files_by_pattern' do
    let(:dir) { AfFrontend::DIRECTORY_TOMMOROW_ICONS }
    let(:pattern) { '11000' }
    let(:image_path) do
      'engines/af_frontend/app/assets/images/af_frontend/tomorrow-icons/11000_mostly_clear_small@2x.png'
    end

    it 'returns a matching file name as a string' do
      expect(helper.get_files_by_pattern(dir, pattern)).to eq(image_path)
    end
  end
end
