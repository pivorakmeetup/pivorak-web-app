# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    name { Faker::TvShows::GameOfThrones.city }
    address { 'Westeros' }
  end
end
