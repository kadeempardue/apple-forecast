module AfCore
  class GeocoderService
    def call
      get_address
    end

    private

    def get_address
      address = Geocoder.address(latitude, longitude)
      address
    end

    def geoapify_service
      @ip_address_service ||= AfCore::GeoapifyService.new
    end
  end
end