module AfCore
  class GeocoderService
    attr_accessor :cache_hit
    attr_reader :latitude, :longitude

    CACHE_DURATION = 1.month

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude
    end

    def call
      get_postal_code
    end

    private

    def cache_name
      "#{latitude}:#{longitude}"
    end

    # Rails.cache.fetch("cache-manager/#{latitude}:#{longitude}/#{digest}")
    # Cache duration is one month since postal codes rarely change.
    def get_postal_code
      AfCore::CacheManager.cached(cache_name, { klass: :geocoder_service }, CACHE_DURATION, self) do
        Geocoder.search([latitude, longitude]).first.postal_code
      end
    end
  end
end