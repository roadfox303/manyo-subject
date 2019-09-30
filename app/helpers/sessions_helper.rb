module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
  def current_admin
    @admin ||= Admin.find_by(user_id: current_user.id)
  end
  def admin?
    current_admin.present?
  end
end
