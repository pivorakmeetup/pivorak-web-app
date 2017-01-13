FactoryGirl.define do
  factory :friend do
    name        Faker::Name.name
    description Faker::Lorem.paragraph
    link        Faker::Internet.url
  end
end
