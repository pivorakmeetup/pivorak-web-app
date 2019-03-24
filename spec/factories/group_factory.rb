# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name     { Faker::Lorem.word }
    resource { 'Talk' }
  end
end
