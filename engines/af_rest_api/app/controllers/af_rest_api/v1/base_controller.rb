# frozen_string_literal: true
require "application_responder"

module AfRestApi
  module V1
    class BaseController < ActionController::Base
      self.responder = ApplicationResponder
      respond_to :json
    end
  end
end
