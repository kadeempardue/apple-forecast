module AfCore
  class GeoapifyService
    IP_SERVICE_URL = 'https://api.geoapify.com/v1'

    def ip_info
      query('ipinfo')
    end

    private

    def query(path)
      @results ||= JSON.parse(Net::HTTP.get(URI.parse(api_url(path))).squish)
    rescue StandardError
      # TODO Bugsnag or similar
      nil
    end

    def params
      { apiKey: ENV['GEOAPIFY_API_KEY'] }
    end

    def api_url(path)
      "#{IP_SERVICE_URL}/#{path}?#{params.to_query}"
    end
  end
end
