class UserStat
  attr_reader :user_id,
              :category,
              :completed_tasks,
              :total_tasks,
              :completed_points,
              :total_points

  def initialize(stats)
    @user_id = stats['user_id']
    @category = stats['category']
    @completed_tasks = stats['completed_tasks'] || 0
    @total_tasks = stats['total_tasks'] || 0
    @completed_points = stats['completed_points'] || 0
    @total_points = stats['total_points'] || 0
  end
end
