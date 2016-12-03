FactoryGirl.define do
  factory :venue do
    name  Faker::Lorem.word
    address Faker::Address.street_address
    maps_url Faker::Internet.url
  end
end