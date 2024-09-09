require_relative "boot"

require "rails/all"
require 'dotenv/load'

%w[ af_rest_api af_frontend af_core ].each do |engine|
  require_relative "../engines/#{engine}/lib/#{engine}"
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppleForecast
  class Application < Rails::Application
    VERSION = Rails.root.join('VERSION').read.strip.freeze

    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Eastern Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # CSRF Protection
    config.action_controller.default_protect_from_forgery = false
    config.action_controller.per_form_csrf_tokens = true
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Middleware
    config.middleware.use Rack::Attack

    # Redis Cache
    unless Rails.env.test?
      config.action_controller.perform_caching = true
      config.action_controller.enable_fragment_cache_logging = true
      config.cache_store = :redis_cache_store, {
        namespace: 'appleforecast_redis',
        host: ENV['REDIS_HOST'],
        port: ENV['REDIS_PORT'],
        compress: true,
        read_timeout: 0.05,
        write_timeout: 0.05,
        reconnect_attempts: 1,
        expires_in: 30.minutes
      }
      config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{30.minutes.to_i}"
      }
    end
  end
end
