# frozen_string_literal: true

FactoryBot.define do
  factory :donation do
    amount     { Faker::Number.decimal(3, 2) }
    payment_id { Faker::Number.number(6) }

    trait :assigned do
      goal
    end
  end
end
