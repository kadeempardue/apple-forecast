# frozen_string_literal: true

AfRestApi::Engine.routes.draw do
  namespace :v1 do
    resources :forecasts, only: %i[] do
      collection do
        post 'search', to: 'forecasts#search'
      end
    end
  end

  match '*not_found', to: 'v1/core/errors#not_found', via: %i[get post put patch]

  root to: 'v1/core/health#index'
end
