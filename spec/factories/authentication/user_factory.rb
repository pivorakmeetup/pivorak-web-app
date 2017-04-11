FactoryGirl.define do
  factory :authentication_user, class: 'Authentication::User' do
    sequence(:email) { |n| "pivorak.member#{n}@example.com" }
    password         Faker::Internet.password(20)
    confirmed_at     Time.zone.now

    trait :tester do
      email 'tester@example.com'
    end
  end
end
