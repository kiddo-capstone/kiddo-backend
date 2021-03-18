class RewardSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :points_to_redeem, :redeemed
  belongs_to :user
  belongs_to :parent
end
