# frozen_string_literal: true

module AfCore
  class Location
    attr_accessor :city, :state, :country, :latitude, :longitude

    def self.build(data)
      instance = new
      instance.city = data[:city]
      instance.state = data[:state]
      instance.country = data[:country]
      instance.latitude = data[:latitude]
      instance.longitude = data[:longitude]
      instance
    end
  end
end
