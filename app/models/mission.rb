class Mission < ApplicationRecord
  has_many :user_missions
  has_many :mission_tasks
  has_many :users, through: :user_missions
  has_many :tasks, through: :mission_tasks
  validates_presence_of :name
end
