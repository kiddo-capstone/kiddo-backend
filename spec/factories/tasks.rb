FactoryBot.define do
  factory :task do
    name {Faker::Name.name}
    description {Faker::Beer.style}
    category {Faker::Food.description}
    points {Faker::Number.within(range: 1..10)}
  end
end
