# frozen_string_literal: true

FactoryGirl.define do
  factory :venue do
    name { Faker::GameOfThrones.city }
    address { 'Westeros' }
  end
end
