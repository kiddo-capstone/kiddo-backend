FactoryBot.define do
  factory :parent do
    name {Faker::Name.name}
    email {Faker::Internet.email}
  end
end
