FactoryBot.define do
  factory :reward do
    user
    parent
    title { "Reward #{rand(100)}" }
    description { Faker::Beer.style }
    points_to_redeem { 30 }
  end
end
