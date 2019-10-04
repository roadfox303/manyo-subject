class AdminController < ApplicationController
  before_action :authority_check
  def index
    
  end

  private

  def authority_check
    raise Forbidden unless current_admin.present?
  end

end
