class MissionTask < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  belongs_to :mission
  belongs_to :task

  def set_defaults
    self.is_completed = false if self.is_completed.nil?
  end
end
