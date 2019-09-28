class ApplicationRecord < ActiveRecord::Base
  # def current_user
  #   @current_user ||= User.find(1)
  # end
  self.abstract_class = true
end
