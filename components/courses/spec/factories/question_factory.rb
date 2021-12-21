# frozen_string_literal: true

FactoryBot.define do
  factory :question, class: 'Courses::Question' do
    body { Faker::Lorem.sentence }
  end
end
