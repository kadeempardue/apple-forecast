# frozen_string_literal: true

module AfRestApi
  class Engine < ::Rails::Engine
    isolate_namespace AfRestApi

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
