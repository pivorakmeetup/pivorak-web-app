FactoryGirl.define do
  factory :email_template do
    subject { Faker::Lorem.sentence }
  end
end
