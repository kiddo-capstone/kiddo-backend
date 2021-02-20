class Task < ApplicationRecord
  has_many :mission_tasks
  has_many :missions, through: :mission_tasks
  validates :name, :description, :type, :points, presence: true
end
