FactoryGirl.define do
  factory :email_template do
    subject { Faker::Lorem.sentence }
    note { Faker::Lorem.sentence }
    title { 'UserMailer#abc' }
    body { Faker::Lorem.word }
  end
end
