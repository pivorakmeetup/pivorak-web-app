# frozen_string_literal: true

FactoryBot.define do
  factory :goal do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    amount      { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
