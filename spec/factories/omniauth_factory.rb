FactoryGirl.define do
  factory :omniauth_params, class: Hash do
    provider Devise.omniauth_providers.sample
    uid      Faker::Number.number(16)
    info {{
      email: Faker::Internet.email,
      name:  Faker::Name.name
    }}

    initialize_with { attributes }
  end
end
