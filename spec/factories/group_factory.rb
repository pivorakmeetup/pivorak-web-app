FactoryGirl.define do
  factory :group do
    name     Faker::Lorem.word
    resource 'Talk'
  end
end
