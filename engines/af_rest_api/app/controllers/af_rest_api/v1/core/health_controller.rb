# frozen_string_literal: true

module AfRestApi
  module V1
    module Core
      class HealthController < AfRestApi::V1::BaseController
        def index
          render json: { meta: data }
        end

        private

        def data
          {
            health: :ok,
            component_name: 'api',
            component_version:,
            app_version: AppleForecast::Application::VERSION
          }
        end

        def component_version
          self.class.module_parent.const_get(:'Version::VERSION')
        rescue NameError
          self.class.name.downcase.split('::')[2].delete_prefix('v')
        end
      end
    end
  end
end
