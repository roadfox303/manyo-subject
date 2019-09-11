class Task < ApplicationRecord
  validates :title, presence: true, length:{ maximum:255 }
  validates :comment, presence: true
  validates :priority, presence: true
end
