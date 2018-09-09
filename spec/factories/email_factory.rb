FactoryBot.define do
  factory :email do
    add_attribute :subject, Faker::Lorem.word
    body Faker::Lorem.paragraph
  end
end
