# frozen_string_literal: true

require 'rails_helper'

describe Courses::InterviewAssessment::BuildAssessments do
  let(:season)                       { create(:season, title: 'Test Season') }
  let(:user)                         { create(:user) }
  let(:first_mentor)                 { ::Courses::Mentor.create(user_id: 1, season: season) }
  let(:second_mentor)                { ::Courses::Mentor.create(user: user, season: season) }
  let(:interview)                    { create(:interview, mentor: first_mentor) }
  let(:first_question)               { create(:question, season: season) }
  let(:second_question)              { create(:question, season: season) }
  let(:new_interview_assessment)     { ::Courses::InterviewAssessment.new(interview: interview, mentor: first_mentor) }
  let(:created_interview_assessment) do
    ::Courses::InterviewAssessment.create(
      interview: interview, mentor: second_mentor
    )
  end

  describe '#call' do
    it "builds assessments for each question for new interview assessment and doesn't build for created one" do
      questions = [first_question, second_question]

      described_class.call(new_interview_assessment, questions)
      described_class.call(created_interview_assessment, questions)

      expect(new_interview_assessment.assessments.size).to eq(questions.size)
      expect(created_interview_assessment.assessments.size).to eq(0)
    end
  end
end
