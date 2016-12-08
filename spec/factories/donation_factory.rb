FactoryGirl.define do
  factory :donation do
    amount Faker::Number.decimal(3, 2)
  end
end
