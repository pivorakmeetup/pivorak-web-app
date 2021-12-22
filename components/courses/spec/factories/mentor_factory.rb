# frozen_string_literal: true

FactoryBot.define do
  factory :mentor, class: 'Courses::Mentor' do
    user
    season
  end
end
