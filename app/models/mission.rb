class Mission < ApplicationRecord
    has_many :user_missions, :mission_tasks
    has_many :users, through: :user_missions 
    has_many :tasks, through: :mission_tasks
end
