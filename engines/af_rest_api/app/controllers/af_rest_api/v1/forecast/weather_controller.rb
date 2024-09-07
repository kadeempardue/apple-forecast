# frozen_string_literal: true

module AfRestApi
  module V1
    module Forecast
      class WeatherController < BaseController
        def index
          render json: { status: :ok }
        end
      end
    end
  end
end