FactoryBot.define do
  factory :task do
    name {Faker::Name.name}
    description {Faker::Beer.style}
    categories = ['brain training', 'health training', 'work training']
    category {categories.sample}
    points {Faker::Number.within(range: 1..10)}
  end
end
