# frozen_string_literal: true

module AfCore
  class TomorrowIoService
    IP_SERVICE_URL = 'https://api.tomorrow.io/v4'
    attr_accessor :cache_hit
    attr_reader :latitude, :longitude

    CACHE_DURATION = 30.minutes

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude
    end

    def call
      AfCore::CacheManager.cached(cache_name, { klass: :tomorrow_io_service }, CACHE_DURATION, self) do
        query('/weather/forecast', location: "#{latitude},#{longitude}", units: :imperial)
      end
    rescue StandardError
      # TODO: Bugsnag or similar
      nil
    end

    private

    def cache_name
      "#{latitude}:#{longitude}"
    end

    def query(path, params)
      @query ||= JSON.parse(Net::HTTP.get(URI.parse(api_url(path, params))).squish)
    end

    def api_key
      { apikey: ENV.fetch('TOMORROW_API_KEY', nil) }
    end

    def api_url(path, params)
      "#{IP_SERVICE_URL}/#{path}?#{params.merge(api_key).to_query}"
    end
  end
end
