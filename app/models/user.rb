

class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_many :mission_tasks, through: :missions
  has_many :tasks, through: :mission_tasks
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  after_initialize :set_defaults

  def set_defaults
    self.points = 0 if self.points.nil?
  end

  def user_stats
    sql = <<-SQL
      select total.user_id, total.category, total.total_tasks, coalesce(completed.completed_tasks,0) completed_tasks, total.total_points, coalesce(completed.completed_points,0) completed_points
      from (
        SELECT  missions.user_id, tasks.category, count(tasks.id) as total_tasks, sum(tasks.points) as total_points FROM "tasks" 
        INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id" 
        INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id" 
        WHERE "missions"."user_id" = #{self.id} 
        GROUP BY "tasks"."category", "missions"."user_id"
      ) total
      full outer join (
        SELECT  missions.user_id, tasks.category, count(tasks.id) as completed_tasks, sum(tasks.points) as completed_points FROM "tasks" 
        INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id" 
        INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id" 
        WHERE "missions"."user_id" = #{self.id} AND (mission_tasks.is_completed = TRUE) 
        GROUP BY "tasks"."category", "missions"."user_id"
      ) completed on total.category = completed.category;
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end
  
  def category_totals
    tasks
    .select('tasks.category, count(tasks.id) as total_tasks, sum(tasks.points) as total_points')
    .group(:category)
    .to_a
  end

  def category_completed
    tasks
    .select('tasks.category, count(tasks.id) as completed_tasks, sum(tasks.points) as completed_points')
    .where('is_completed = ?', true)
    .group(:category)
    .to_a
  end
end
