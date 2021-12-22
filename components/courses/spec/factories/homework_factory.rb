# frozen_string_literal: true

FactoryBot.define do
  factory :homework, class: 'Courses::Homework' do
    lecture
    git_url { 'git' }
  end
end
