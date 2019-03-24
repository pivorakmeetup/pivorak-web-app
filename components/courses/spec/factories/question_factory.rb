# frozen_string_literal: true

FactoryGirl.define do
  factory :question, class: Courses::Question do
    body { Faker::Lorem.sentence }
  end
end
