# frozen_string_literal: true

require 'application_responder'

module AfRestApi
  module V1
    class BaseController < ActionController::Base
      prepend_view_path AfFrontend::Engine.root.join('app/views/af_frontend')

      self.responder = ApplicationResponder
      respond_to :json
    end
  end
end
