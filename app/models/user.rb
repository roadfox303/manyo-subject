class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, length: { maximum:255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true
    before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum:8 }
  has_many :tasks
  has_one :admin
end
