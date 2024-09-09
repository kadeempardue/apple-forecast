module AfFrontend
  class ForecastsController < ActionController::Base
    prepend_view_path AfFrontend::Engine.root.join('app/views/af_frontend')

    layout 'af_frontend/application'

    def index
      @forecast = forecast_query.perform
      respond_to do |format|
        format.html
      end
    end

    def search
      # @forecast = forecast_query.perform
      respond_to do |format|
        format.js
      end
    end

    private

    def forecast_query
      @forecast_query ||= AfCore::ForecastQuery.new
    end
  end
end