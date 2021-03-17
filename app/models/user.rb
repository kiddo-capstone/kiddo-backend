class User < ApplicationRecord
  belongs_to :parent
  has_many :rewards
  has_many :missions, dependent: :destroy
  has_many :mission_tasks, through: :missions
  has_many :tasks, through: :mission_tasks
  validates :name, presence: true
  after_initialize :set_defaults

  def set_defaults
    self.points = 0 if points.nil?
  end

  def user_stats
    sql = <<-SQL
      select total.user_id, total.category, total.total_tasks, coalesce(completed.completed_tasks,0) completed_tasks, total.total_points, coalesce(completed.completed_points,0) completed_points
      from (
        SELECT  missions.user_id, tasks.category, count(tasks.id) as total_tasks, sum(tasks.points) as total_points FROM "tasks"#{' '}
        INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id"#{' '}
        INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id"#{' '}
        WHERE "missions"."user_id" = #{id}#{' '}
        GROUP BY "tasks"."category", "missions"."user_id"
      ) total
      full outer join (
        SELECT  missions.user_id, tasks.category, count(tasks.id) as completed_tasks, sum(tasks.points) as completed_points FROM "tasks"#{' '}
        INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id"#{' '}
        INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id"#{' '}
        WHERE "missions"."user_id" = #{id} AND (mission_tasks.is_completed = TRUE)#{' '}
        GROUP BY "tasks"."category", "missions"."user_id"
      ) completed on total.category = completed.category;
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end
end
