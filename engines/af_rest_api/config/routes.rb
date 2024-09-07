AfRestApi::Engine.routes.draw do
  namespace :v1 do
    namespace :forecast do
      get 'weather', to: 'weather#index', as: :get_weather_forecast
    end
  end

  match '*not_found', to: 'v1/core/errors#not_found', via: %i[get post put patch]

  root to: 'v1/core/health#index'
end
