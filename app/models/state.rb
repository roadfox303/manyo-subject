class State < ApplicationRecord
  has_many :statuses, dependent: :destroy
  has_many :tasks, :through => :statuses
  has_many :state_tasks, through: :statuses, source: :task

  # scope :search_progress, ->(progress_id) { find(progress_id).tasks }
  scope :search_progress, ->(progress_id,current_user_id) { find(progress_id).tasks.where(user_id: current_user_id)}

end
