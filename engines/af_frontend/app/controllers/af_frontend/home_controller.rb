module AfFrontend
  class HomeController < ActionController::Base
    prepend_view_path AfFrontend::Engine.root.join('app/views/af_frontend')

    def index
      respond_to do |format|
        format.html
      end
    end
  end
end