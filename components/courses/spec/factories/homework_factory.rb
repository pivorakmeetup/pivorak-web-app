# frozen_string_literal: true

FactoryGirl.define do
  factory :homework, class: Courses::Homework do
    git_url { 'git' }
  end
end
