class Task < ApplicationRecord
  has_many :mission_tasks
  has_many :missions, through: :mission_tasks
end
