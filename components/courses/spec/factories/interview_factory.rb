# frozen_string_literal: true

FactoryGirl.define do
  factory :interview, class: Courses::Interview do
    start_at { Time.now }
  end
end
