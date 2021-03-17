FactoryBot.define do
  factory :mission do
    user
    name { "Weekly #{Faker::Creature::Animal.name} chores" }
    due_date { Time.zone.today + 5.days }
    created_at { Time.zone.today }
    updated_at { Time.zone.today }
  end
end
