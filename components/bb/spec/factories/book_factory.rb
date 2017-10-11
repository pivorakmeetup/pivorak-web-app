FactoryGirl.define do
  factory :book, class: Bb::Book do
    member_id   1
    title       { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
