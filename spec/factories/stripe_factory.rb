# frozen_string_literal: true

FactoryBot.define do
  factory :valid_credit_card, class: Hash do
    number     { '42' * 8 }
    exp_month  { Faker::Number.between(from: 1, to: 12) }
    exp_year   { Time.now.year.next.to_s }
    cvc        { Faker::Number.number(digits: 3) }

    initialize_with { attributes }
  end

  factory :valid_customer, class: Hash do
    email { Faker::Internet.email }

    initialize_with { attributes }
  end

  factory :valid_charge, class: Hash do
    amount      { Faker::Number.number(digits: 3) }
    description { Faker::Lorem.paragraph }

    initialize_with { attributes }
  end
end
