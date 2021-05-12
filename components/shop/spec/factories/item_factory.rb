# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Shop::Item do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.word }
    price       { 12 }
  end
end
