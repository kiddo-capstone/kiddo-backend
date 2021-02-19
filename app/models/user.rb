class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: {case_sensitive: true}, presence: true
  validates :name, uniqueness: true, presence: true
  has_many :user_missions
  has_many :missions, through: :user_missions
end
