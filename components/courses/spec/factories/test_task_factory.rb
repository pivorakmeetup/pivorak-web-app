# frozen_string_literal: true

FactoryBot.define do
  factory :test_task, class: 'Courses::TestTask' do
    git_url { Faker::Internet.url }
  end
end
