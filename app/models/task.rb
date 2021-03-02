class Task < ApplicationRecord
  has_many :mission_tasks, dependent: :destroy
  has_many :missions, through: :mission_tasks
  validates :name, :description, :category, presence: true
  validates :points, :numericality => { :greater_than => 0, only_integer: true }, presence: true

end
