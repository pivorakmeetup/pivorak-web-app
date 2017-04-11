FactoryGirl.define do
  factory :authorization_user, class: 'Authorization::User' do
    user_id 0
    admin false
    verified false
    synthetic false

    trait :admin do
      admin true
    end

    trait :verified do
      verified true
    end

    trait :synth do
      synthetic true
    end
  end
end
