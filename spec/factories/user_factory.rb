FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "person#{n}@example.com" }
    password Faker::Internet.password(20)

    trait :admin do
      admin true
    end

  end
end
