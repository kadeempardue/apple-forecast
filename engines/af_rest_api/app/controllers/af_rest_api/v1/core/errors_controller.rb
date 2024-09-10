# frozen_string_literal: true

module AfRestApi
  module V1
    module Core
      class ErrorsController < AfRestApi::V1::BaseController
        def not_found
          @error_number = 404
          @not_found_path = params[:not_found]
          respond_to do |format|
            format.json { render json: { errors: [{ path: @not_found_path }] }, status: @error_number }
            format.js { render json: { errors: [{ path: @not_found_path }] }, status: @error_number }
          end
        end
      end
    end
  end
end
