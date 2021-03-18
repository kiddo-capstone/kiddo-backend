class Parent < ApplicationRecord
  has_many :rewards, dependent: :destroy
  has_many :users, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
