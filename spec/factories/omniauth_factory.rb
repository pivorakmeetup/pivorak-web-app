# frozen_string_literal: true

FactoryBot.define do
  factory :omniauth_params, class: Hash do
    provider { Devise.omniauth_providers.sample }
    uid      { SecureRandom.uuid }
    info do
      {
        email:      Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name:  Faker::Name.last_name
      }
    end

    initialize_with { attributes }

    after(:build) do |instance, _|
      instance[:info][:name] = instance[:info].values_at(:first_name, :last_name).join(' ').to_s
    end
  end

  factory :twitter_params, class: Hash do
    provider { 'twitter' }
    uid      { SecureRandom.uuid }
    info do
      {
        email: Faker::Internet.email,
        name:  Faker::Name.name
      }
    end

    initialize_with { attributes }
  end

  factory :facebook_params, class: Hash do
    provider { 'facebook' }
    uid      { SecureRandom.uuid }
    info do
      {
        email: Faker::Internet.email,
        name:  Faker::Name.name
      }
    end

    initialize_with { attributes }
  end

  factory :github_params, class: Hash do
    provider { 'github' }
    uid      { SecureRandom.uuid }
    info do
      {
        email: Faker::Internet.email,
        name:  Faker::Name.name
      }
    end

    initialize_with { attributes }
  end
end
