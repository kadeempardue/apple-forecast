module AfCore
  class ForecastQuery
    def perform
      build_forecast
    end

    private

    def build_forecast
      AfCore::Forecast.build_from_timelines(timelines)
    end

    def timelines
      @timelines ||= tomorrow_io_service.call
    end

    def latitude
      location&.[]('latitude')
    end

    def longitude
      location&.[]('longitude')
    end

    def location
      ip_info&.[]('location')
    end

    def ip_info
      geoapify_service.ip_info
    end

    def geoapify_service
      @geoapify_service ||= AfCore::GeoapifyService.new
    end

    def tomorrow_io_service
      @tomorrow_io_service ||= AfCore::TomorrowIoService.new(latitude, longitude)
    end
  end
end