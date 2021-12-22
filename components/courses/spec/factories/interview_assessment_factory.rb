# frozen_string_literal: true

FactoryBot.define do
  factory :interview_assessment, class: 'Courses::InterviewAssessment' do
    interview
    mentor
  end
end
