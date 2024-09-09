# frozen_string_literal: true

module AfCore
  class ActiveResourceBase < ActiveResource::Base
    self.site = "#{ENV.fetch('APPLE_FORECAST_API_URL', nil)}/#{ENV.fetch('APPLE_FORECAST_API_VERSION', nil)}"
  end
end
