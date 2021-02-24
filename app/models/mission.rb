class Mission < ApplicationRecord
  belongs_to :user
  has_many :mission_tasks
  has_many :tasks, through: :mission_tasks
  validates_presence_of :name, :due_date, :user_id

  def self.get_tasks(id)
    mission = Mission.find_by(id: id)
    mission.tasks
           .select("mission_tasks.id,
                    mission_tasks.mission_id,
                    mission_tasks.task_id,
                    tasks.name as task_name,
                    tasks.description as task_description,
                    tasks.points,
                    tasks.category as task_category,
                    mission_tasks.message,
                    mission_tasks.image_path,
                    mission_tasks.is_completed") if mission
  end
end
