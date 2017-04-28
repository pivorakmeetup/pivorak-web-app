FactoryGirl.define do
  factory :liqpay_valid_response_data, class: Hash do
    status     :success
    amount     Faker::Number.number(3)
    payment_id Faker::Number.number(6)

    initialize_with { attributes }
  end

  factory :liqpay_error_response_data, class: Hash do
    status     :failure
    amount     Faker::Number.number(3)
    payment_id Faker::Number.number(6)

    initialize_with { attributes }
  end

  factory :liqpay_notification_response_data, class: Hash do
    status     :notification
    amount     Faker::Number.number(3)
    payment_id Faker::Number.number(6)

    initialize_with { attributes }
  end

  trait :customer do
    customer '1'
  end
end
