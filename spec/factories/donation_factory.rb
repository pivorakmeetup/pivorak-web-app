# frozen_string_literal: true

FactoryBot.define do
  factory :donation do
    amount     { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    payment_id { Faker::Number.number(digits: 6) }

    trait :assigned do
      goal
    end
  end
end
