# frozen_string_literal: true

module AfRestApi
  module V1
    module Core
      class ErrorsController < ActionController::Base
        def not_found
          @error_number = 404
          @not_found_path = params[:not_found]
          respond_to do |format|
            format.html { render 'af_frontend/errors/index', status: @error_number }
            format.js { render json: { errors: [@error_name] }, status: @error_number }
          end
        end
      end
    end
  end
end
