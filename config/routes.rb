# frozen_string_literal: true

AppleForecast::Application.routes.draw do
  mount AfRestApi::Engine => '/api', as: :af_rest_api
  mount AfFrontend::Engine => '/', as: :af_frontend
end
