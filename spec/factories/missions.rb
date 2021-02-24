FactoryBot.define do
  factory :mission do
    name { "Weekly #{Faker::Creature::Animal.name} chores" }
    due_date { Time.zone.today + 5.days }
    user
    created_at { Time.zone.today }
    updated_at { Time.zone.today }
  end
end
