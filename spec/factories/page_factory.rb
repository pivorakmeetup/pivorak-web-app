FactoryGirl.define do
  factory :page do
    title Faker::Lorem.word
    url   Faker::Lorem.word
    body  Faker::Lorem.paragraph
  end
end
