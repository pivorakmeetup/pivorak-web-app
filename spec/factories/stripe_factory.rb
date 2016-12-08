FactoryGirl.define do
  factory :valid_credit_card, class: Hash do
    number     '42' *  8
    exp_month  Faker::Number.between(1, 12)
    exp_year   (Time.now.year + 1).to_s
    cvc        Faker::Number.number(3)

    initialize_with { attributes }
  end

  factory :valid_customer, class: Hash do
    email Faker::Internet.email

    initialize_with { attributes }
  end

  factory :valid_charge, class: Hash do
    amount      Faker::Number.number(3)
    description Faker::Lorem.paragraph

    initialize_with { attributes }
  end
end
