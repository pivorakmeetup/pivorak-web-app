# frozen_string_literal: true

FactoryBot.define do
  factory :season, class: 'Courses::Season' do
    title     { Faker::Lorem.word }
    start_at  { Time.current }
    finish_at { Time.current + 100.days }
  end
end
