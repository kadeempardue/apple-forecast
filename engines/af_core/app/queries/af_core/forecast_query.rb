# frozen_string_literal: true

module AfCore
  class ForecastQuery
    attr_accessor :cache_hit
    attr_reader :query_info

    CACHE_DURATION = 30.minutes

    def initialize(query_info = nil)
      @query_info = query_info
    end

    def perform
      AfCore::Forecast.build(location: location_data, timelines: timelines_data)
    end

    private

    def timelines_data
      AfCore::CacheManager.cached(cache_name, { klass: :forecast_query }, CACHE_DURATION, self) do
        tomorrow_io_service.call
      end
    end

    def location_data
      {
        city:,
        state:,
        country:,
        latitude:,
        longitude:,
        postal_code:
      }
    end

    def city
      query_info.present? ? query_info&.[]('city') : ip_info['city']&.[]('name')
    end

    def state
      query_info.present? ? query_info&.[]('state') : ip_info['state']&.[]('name')
    end

    def country
      query_info.present? ? query_info&.[]('country') : ip_info['country']&.[]('name')
    end

    def latitude
      query_info.present? ? query_info&.[]('lat') : ip_info&.[]('location')&.[]('latitude')
    end

    def longitude
      query_info.present? ? query_info&.[]('lon') : ip_info&.[]('location')&.[]('longitude')
    end

    def postal_code
      query_info.present? ? query_info&.[]('postcode') : geocoder_service(latitude, longitude).call
    end

    def cache_name
      postal_code
    end

    def ip_info
      @ip_info ||= geoapify_service.ip_info
    end

    def geoapify_service
      @geoapify_service ||= AfCore::GeoapifyService.new
    end

    def geocoder_service(latitude, longitude)
      @geocoder_service ||= AfCore::GeocoderService.new(latitude, longitude)
    end

    def tomorrow_io_service
      @tomorrow_io_service ||= AfCore::TomorrowIoService.new(latitude, longitude)
    end
  end
end
