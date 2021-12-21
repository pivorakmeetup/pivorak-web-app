# frozen_string_literal: true

FactoryBot.define do
  factory :student, class: 'Courses::Student' do
    user_id         { rand(0..100) }
    status          { rand(0..6) }
    personal_info   { Faker::Lorem.sentence }
    motivation_info { Faker::Lorem.sentence }
    experience_info { Faker::Lorem.sentence }
    devote_info     { Faker::Lorem.sentence }
  end
end
