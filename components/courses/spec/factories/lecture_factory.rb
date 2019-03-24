# frozen_string_literal: true

FactoryBot.define do
  factory :lecture, class: Courses::Lecture do
    title       { Faker::TvShows::GameOfThrones.house }
    started_at  { Time.now }
    finished_at { Time.now + 100.days }
  end
end
