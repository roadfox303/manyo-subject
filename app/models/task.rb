class Task < ApplicationRecord
  validates :title, presence: true, length:{ maximum:255 }
  validates :comment, presence: true
  validates :priority, presence: true
  has_many :statuses, dependent: :destroy
  # has_many :state, :through => :statuses
  has_many :status_state, through: :statuses, source: :state
  accepts_nested_attributes_for :statuses, allow_destroy: true
  # accepts_nested_attributes_for :labels, allow_destroy: true
  belongs_to :user

  # deletedカラムがfalseであるものを取得する
  # scope :search, -> {
  #   where(deleted: false)
  # }
  # created_atカラムを降順で取得する
  # scope :sort, -> { order(created_at: :desc) }
  # activeとsortedを合わせたもの
  # scope :recent, -> { search.sort }
  scope :result_task, ->(array_result, type, direction) { where(id: array_result).order("#{type} #{direction}") }
  scope :sort_task, ->(type, direction) { order("#{type} #{direction}") }
  enum priority_id: [['---',0], ['低', 1], ['中', 2],['高', 3]]

end
