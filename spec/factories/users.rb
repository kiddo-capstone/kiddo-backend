FactoryBot.define do
  factory :user do
    parent
    name {Faker::Name.name}
  end
end
