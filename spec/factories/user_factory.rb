FactoryGirl.define do
  factory :user do
    name     Faker::Name.name
    email    Faker::Internet.email
    password Faker::Internet.password(20)
  end
end
