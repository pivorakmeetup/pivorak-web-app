FactoryGirl.define do
  factory :interview_assessment, class: Courses::InterviewAssessment do
    interview_id { rand(0..100) }
    mentor_id    { rand(0..100) }
  end
end
