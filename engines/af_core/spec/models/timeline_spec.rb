require "rails_helper"

RSpec.describe AfCore::Timeline, type: :model do
  let(:subject) { build(:timeline) }
  let(:daily_attributes) do
    %w(
      cloud_base_avg cloud_base_max cloud_base_min cloud_ceiling_avg cloud_ceiling_max cloud_ceiling_min
      cloud_cover_avg cloud_cover_max cloud_cover_min dew_point_avg dew_point_max dew_point_min
      evapotranspiration_avg evapotranspiration_max evapotranspiration_min evapotranspiration_sum
      freezing_rain_intensity_avg freezing_rain_intensity_max freezing_rain_intensity_min
      humidity_avg humidity_max humidity_min ice_accumulation_avg ice_accumulation_lwe_avg
      ice_accumulation_lwe_max ice_accumulation_lwe_min ice_accumulation_lwe_sum ice_accumulation_max
      ice_accumulation_min ice_accumulation_sum moonrise_time moonset_time precipitation_probability_avg
      precipitation_probability_max precipitation_probability_min pressure_surface_level_avg
      pressure_surface_level_max pressure_surface_level_min rain_accumulation_avg rain_accumulation_lwe_avg
      rain_accumulation_lwe_max rain_accumulation_lwe_min rain_accumulation_max rain_accumulation_min
      rain_accumulation_sum rain_intensity_avg rain_intensity_max rain_intensity_min sleet_accumulation_avg
      sleet_accumulation_lwe_avg sleet_accumulation_lwe_max sleet_accumulation_lwe_min
      sleet_accumulation_lwe_sum sleet_accumulation_max sleet_accumulation_min sleet_intensity_avg
      sleet_intensity_max sleet_intensity_min snow_accumulation_avg snow_accumulation_lwe_avg
      snow_accumulation_lwe_max snow_accumulation_lwe_min snow_accumulation_lwe_sum snow_accumulation_max
      snow_accumulation_min snow_accumulation_sum snow_depth_avg snow_depth_max snow_depth_min
      snow_depth_sum snow_intensity_avg snow_intensity_max snow_intensity_min sunrise_time sunset_time
      temperature_apparent_avg temperature_apparent_max temperature_apparent_min temperature_avg
      temperature_max temperature_min uv_health_concern_avg uv_health_concern_max uv_health_concern_min
      uv_index_avg uv_index_max uv_index_min visibility_avg visibility_max visibility_min
      weather_code_max weather_code_min wind_direction_avg wind_gust_avg wind_gust_max wind_gust_min
      wind_speed_avg wind_speed_max wind_speed_min
    )
  end

  describe '#daily?' do
    it 'returns true when timeline_type is daily' do
      expect(subject.daily?).to eq(true)
    end

    context 'when timeline_type is hourly' do
      let(:subject) { build(:timeline, timeline_type: :hourly) }

      it 'returns false' do
        expect(subject.daily?).to eq(false)
      end
    end

    context 'when timeline_type is minutely' do
      let(:subject) { build(:timeline, timeline_type: :minutely) }

      it 'returns false' do
        expect(subject.daily?).to eq(false)
      end
    end
  end

  describe '#hourly?' do
    let(:subject) { build(:timeline, timeline_type: :hourly) }

    it 'returns true when timeline_type is hourly' do
      expect(subject.hourly?).to eq(true)
    end

    context 'when timeline_type is daily' do
      let(:subject) { build(:timeline, timeline_type: :daily) }

      it 'returns false' do
        expect(subject.hourly?).to eq(false)
      end
    end

    context 'when timeline_type is minutely' do
      let(:subject) { build(:timeline, timeline_type: :minutely) }

      it 'returns false' do
        expect(subject.hourly?).to eq(false)
      end
    end
  end

  describe '#minutely?' do
    let(:subject) { build(:timeline, timeline_type: :minutely) }

    it 'returns true when timeline_type is minutely' do
      expect(subject.minutely?).to eq(true)
    end

    context 'when timeline_type is daily' do
      let(:subject) { build(:timeline, timeline_type: :daily) }

      it 'returns false' do
        expect(subject.minutely?).to eq(false)
      end
    end

    context 'when timeline_type is hourly' do
      let(:subject) { build(:timeline, timeline_type: :hourly) }

      it 'returns false' do
        expect(subject.minutely?).to eq(false)
      end
    end
  end

  describe '#getters' do
    it 'defines getters' do
      daily_attributes.each { |attribute| expect(subject).to respond_to(attribute) }
    end
  end

  describe '#setters' do
    it 'defines getters' do
      daily_attributes.each { |attribute| expect(subject).to respond_to("#{attribute}=") }
    end
  end
end