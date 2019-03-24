# frozen_string_literal: true

FactoryBot.define do
  factory :season, class: Courses::Season do
    title     { Faker::Lorem.word }
    start_at  { Time.now }
    finish_at { Time.now + 100.days }
  end
end
