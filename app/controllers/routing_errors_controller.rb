class RoutingErrorsController < ApplicationController
  def index
    raise ActionController::RoutingError,"以下のurlにはアクセスできません => #{request.path.inspect}"
  end
end
