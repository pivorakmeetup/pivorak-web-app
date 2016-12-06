FactoryGirl.define do
  factory :goal do
    title       Faker::Lorem.word
    description Faker::Lorem.paragraph
    amount      Faker::Number.decimal(3, 2)
  end

  trait :with_donations do
    after :create do |goal|
      FactoryGirl.create_list :donation, 3, goal: goal
    end
  end
end
