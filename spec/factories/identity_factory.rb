# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    provider { Devise.omniauth_providers.sample }
    uid      { Faker::Number.number(16) }
  end
end
