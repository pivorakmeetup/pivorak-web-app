FactoryBot.define do
  factory :email do
    subject { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }
  end
end
