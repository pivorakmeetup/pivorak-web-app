FactoryGirl.define do
  factory :student, class: Courses::Student do
    user_id         { rand(0..100) }
    status          { rand(0..5) }
    personal_info   { 'Some personal info' }
    motivation_info { 'Some motivation info' }
  end
end
