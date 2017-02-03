FactoryGirl.define do
  factory :page do
    title Faker::Lorem.word
    sequence(:url) { |n| "page-#{n}" }
    body Faker::Lorem.paragraph
  end
end
