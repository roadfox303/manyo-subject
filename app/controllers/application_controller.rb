class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  private
    def rescue403(e)
      @exception = e
      render file: Rails.root.join('public/403.html'), status: 403
    end
end
