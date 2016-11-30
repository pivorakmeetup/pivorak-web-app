FactoryGirl.define do
  factory :event do
    title  Faker::Lorem.word
    agenda Faker::Lorem.paragraph
  end
end
