class Tag < ApplicationRecord
  # has_many :labels, dependent: :destroy
  # has_many :tasks, :through => :labels
  # has_many :tag_tasks, through: :labels, source: :task

end
