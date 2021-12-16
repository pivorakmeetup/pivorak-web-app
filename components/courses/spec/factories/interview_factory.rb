# frozen_string_literal: true

FactoryBot.define do
  factory :interview, class: Courses::Interview do
    start_at { Time.current }
  end
end
