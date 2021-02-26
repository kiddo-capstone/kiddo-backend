class MissionTask < ApplicationRecord

  include Rails.application.routes.url_helpers
  
  after_initialize :set_defaults, unless: :persisted?
  has_one_attached :image

  belongs_to :mission
  belongs_to :task

  def set_defaults
    self.is_completed = false if self.is_completed.nil?
  end

  def get_image_url
    url_for(self.image)
  end
end
