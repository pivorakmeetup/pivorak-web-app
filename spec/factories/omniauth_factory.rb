FactoryGirl.define do
  factory :omniauth_params, class: Hash do
    provider Devise.omniauth_providers.sample
    uid      Faker::Number.number(16)
    info {{
      email: Faker::Internet.email,
      first_name:  Faker::Name.first_name,
      last_name:  Faker::Name.last_name
    }}

    initialize_with { attributes }
  end
end
