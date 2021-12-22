# frozen_string_literal: true

FactoryBot.define do
  factory :friend do
    name        { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    link        { Faker::Internet.url }
    logo        { File.open(Rails.root.join('spec/fixtures/images/pivorak.png')) }

    trait :published do
      published { true }
    end
  end
end
