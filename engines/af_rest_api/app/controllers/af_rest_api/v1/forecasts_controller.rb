# frozen_string_literal: true

module AfRestApi
  module V1
    class ForecastsController < BaseController
      def index
        render json: { status: :ok }
      end

      def create
        render json: { status: :ok }
      end
    end
  end
end