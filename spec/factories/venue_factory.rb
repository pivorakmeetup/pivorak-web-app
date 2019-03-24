# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    name  { Faker::Lorem.word }
    address { Faker::Address.street_address }
    map_url { Faker::Internet.url }
  end
end
