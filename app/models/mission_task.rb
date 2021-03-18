class MissionTask < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_initialize :set_defaults, unless: :persisted?
  has_one_attached :image

  belongs_to :mission
  belongs_to :task
  scope :completed, -> {where('is_completed = ?', true)}

  def set_defaults
    self.is_completed = false if is_completed.nil?
  end

  def adjust_points(new_is_completed)
    user = mission.user
    task_pts = task.points
    user_points = user.points
    if new_is_completed
      user.update(points: user_points + task_pts)
    else
      user.update(points: user_points - task_pts)
    end
  end
end
