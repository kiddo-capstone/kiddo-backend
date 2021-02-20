class Mission < ApplicationRecord
  belongs_to :user
  has_many :mission_tasks
  has_many :tasks, through: :mission_tasks
  validates_presence_of :name
end
