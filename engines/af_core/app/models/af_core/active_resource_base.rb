module AfCore
  class ActiveResourceBase < ActiveResource::Base
    self.site = "#{ENV['APPLE_FORECAST_API_URL']}/#{ENV['APPLE_FORECAST_API_VERSION']}"
  end
end
