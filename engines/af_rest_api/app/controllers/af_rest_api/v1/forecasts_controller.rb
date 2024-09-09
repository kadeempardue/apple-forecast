# frozen_string_literal: true

module AfRestApi
  module V1
    class ForecastsController < BaseController
      def search
        @forecast = forecast_query.perform
        @current_timeline = @forecast.now_timeline
        @cache_hit = forecast_query.cache_hit

        respond_to do |format|
          format.js { render template: 'forecasts/search' }
          format.json { render json: { forecast: @forecast } }
        end
      end

      private

      def properties
        JSON.parse(URI.decode_www_form_component(permitted_params[:properties]))
      end

      def forecast_query
        @forecast_query ||= AfCore::ForecastQuery.new(properties)
      end

      def permitted_params
        params.permit(:properties)
      end
    end
  end
end