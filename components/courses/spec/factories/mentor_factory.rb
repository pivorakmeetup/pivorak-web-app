# frozen_string_literal: true

FactoryBot.define do
  factory :mentor, class: 'Courses::Mentor' do
    user_id         { rand(0..100) }
    season_id       { rand(0..6) }
  end
end
