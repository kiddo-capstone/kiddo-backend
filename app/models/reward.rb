class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :parent
  validates :title, presence: true
  validates :points_to_redeem, :numericality => { :greater_than => 0, only_integer: true }, presence: true
  after_initialize :set_defaults

  def set_defaults
    self.redeemed = false if redeemed.nil?
  end
end
