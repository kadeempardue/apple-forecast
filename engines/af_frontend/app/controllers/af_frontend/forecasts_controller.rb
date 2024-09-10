# frozen_string_literal: true

module AfFrontend
  class ForecastsController < ActionController::Base
    prepend_view_path AfFrontend::Engine.root.join('app/views/af_frontend')

    layout 'af_frontend/application'

    def index
      @forecast = forecast_query.perform
      @current_timeline = @forecast.now_timeline
      @cache_hit = forecast_query.cache_hit
    end

    private

    def forecast_query
      @forecast_query ||= AfCore::ForecastQuery.new
    end
  end
end
