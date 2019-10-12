# frozen_string_literal: true

FactoryBot.define do
  factory :talk do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    video_url   { Faker::Internet.url(host: 'youtube.com') }
    slides_url  { Faker::Internet.url(host: 'slideshare.net') }
    published   { true }
  end

  trait :assigned do
    event
  end
end
