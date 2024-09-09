module AfCore
  class TomorrowIoService
    IP_SERVICE_URL = 'https://api.tomorrow.io/v4'
    attr_reader :latitude, :longitude

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude
    end

    def call
      query('/weather/forecast', location: "#{latitude},#{longitude}" )
    rescue StandardError
      # TODO Bugsnag or similar
      nil
    end

    private

    def query(path, params)
      @results ||= JSON.parse(Net::HTTP.get(URI.parse(api_url(path, params))).squish)
    end

    def api_key
      { apikey: ENV['TOMORROW_API_KEY'] }
    end

    def api_url(path, params)
      "#{IP_SERVICE_URL}/#{path}?#{params.merge(api_key).to_query}"
    end
  end
end


