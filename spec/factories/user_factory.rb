FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "#{Faker::Name.first_name}#{n}" }
    sequence(:last_name) { |n| "#{Faker::Name.last_name}#{n}" }
    sequence(:email) { |n| "pivorak.member#{n}@example.com" }
    password         Faker::Internet.password(20)
    confirmed_at     Time.zone.now

    trait :admin do
      admin true
    end

    trait :verified do
      verified true
    end

    trait :tester do
      email      'tester@example.com'
      first_name 'Tester'
      last_name  'User'
    end

    trait :synth do
      email      'synth@example.com'
      first_name 'Synth'
      last_name  'User'
      synthetic  true
    end
  end
end
