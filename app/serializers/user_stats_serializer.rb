class UserStatsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :category, :completed_tasks, :total_tasks, :completed_points, :total_points
end
