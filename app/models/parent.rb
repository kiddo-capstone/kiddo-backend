class Parent < ApplicationRecord
  has_many :rewards
  has_many :users, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
