FactoryGirl.define do
  factory :user do
    name     Faker::Name.name
    email    Faker::Internet.email
    password Faker::Internet.password(20)

    trait :admin do
      admin true
    end
  end
end
