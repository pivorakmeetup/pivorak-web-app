# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title       { Faker::Lorem.word }
    agenda      { Faker::Lorem.paragraph }
    status      { Event::REGISTRATION }
    venue
    published   { true }
    started_at  { Time.now }
    finished_at { Time.now }
  end
end
