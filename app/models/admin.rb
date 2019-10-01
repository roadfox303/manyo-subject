class Admin < ApplicationRecord
  belongs_to :user
  before_destroy :last_admin

  private

  def last_admin
    hrow(:abort) unless Admin.all.size > 1
  end
end
