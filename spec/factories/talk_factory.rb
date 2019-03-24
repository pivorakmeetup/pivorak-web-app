# frozen_string_literal: true

FactoryBot.define do
  factory :talk do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    video_url   { Faker::Internet.url('youtube.com') }
    slides_url  { Faker::Internet.url('slideshare.net') }
    published   { true }
  end

  trait :assigned do
    event
  end
end
