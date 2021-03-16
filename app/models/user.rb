class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  validates :name, presence: true
  after_initialize :set_defaults
end

def set_defaults
  self.points = 0 if self.points.nil?
end
