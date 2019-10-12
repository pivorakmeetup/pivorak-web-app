# frozen_string_literal: true

FactoryBot.define do
  factory :goal do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    amount      { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end

  trait :with_donations do
    after :create do |goal|
      create :donation, goal: goal
    end
  end
end
