FactoryGirl.define do
  factory :lecture, class: Courses::Lecture do
    title       { Faker::GameOfThrones.house }
    started_at  { Time.now }
    finished_at { Time.now + 100.days }
  end
end
