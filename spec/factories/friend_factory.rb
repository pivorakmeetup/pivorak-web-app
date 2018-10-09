FactoryBot.define do
  factory :friend do
    name        Faker::Name.name
    description Faker::Lorem.paragraph
    link        Faker::Internet.url
    logo        File.open(Rails.root + 'spec/fixtures/images/pivorak.png')

    trait :published do
      published true
    end
  end
end
