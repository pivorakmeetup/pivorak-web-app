# frozen_string_literal: true

FactoryBot.define do
  factory :goal do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    amount      { Faker::Number.decimal(3, 2) }
  end

  trait :with_donations do
    after :create do |goal|
      create :donation, goal: goal
    end
  end
end
