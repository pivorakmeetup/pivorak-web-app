FactoryGirl.define do
  factory :student, class: Courses::Student do
    user_id         { rand(0..100) }
    status          { rand(0..6) }
    personal_info   { Faker::Lorem.sentence }
    motivation_info { Faker::Lorem.sentence }
  end
end
