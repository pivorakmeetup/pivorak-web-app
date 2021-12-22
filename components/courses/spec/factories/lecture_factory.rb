# frozen_string_literal: true

FactoryBot.define do
  factory :lecture, class: 'Courses::Lecture' do
    venue
    mentor
    title       { Faker::TvShows::GameOfThrones.house }
    started_at  { Time.current }
    finished_at { Time.current + 100.days }
  end
end
