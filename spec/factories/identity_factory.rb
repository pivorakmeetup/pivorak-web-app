# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    provider { Devise.omniauth_providers.sample }
    uid      { SecureRandom.uuid }
  end
end
