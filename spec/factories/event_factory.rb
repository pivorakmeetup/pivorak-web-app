FactoryGirl.define do
  factory :event do
    title       Faker::Lorem.word
    agenda      Faker::Lorem.paragraph
    started_at  Time.now
    finished_at Time.now
  end
end
