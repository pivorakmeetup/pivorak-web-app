require 'rails_helper'

describe Courses::Interview::AverageAssessment do
  let!(:season)                      { create(:season, title: 'Test Season') }
  let!(:first_mentor)                { ::Courses::Mentor.create(user_id: 1, season: season) }
  let!(:second_mentor)               { ::Courses::Mentor.create(user_id: 2, season: season) }
  let!(:interview)                   { create(:interview, mentor: first_mentor) }
  let!(:question)                    { create(:question, season: season) }
  let!(:first_interview_assessment)  { ::Courses::InterviewAssessment.create(interview: interview, mentor: first_mentor) }
  let!(:first_mentor_assessment)     { ::Courses::Assessment.create(interview_assessment: first_interview_assessment, question: question, mark: rand(::Courses::Assessment::RANGE)) }
  let!(:second_interview_assessment) { ::Courses::InterviewAssessment.create(interview_id: interview.id, mentor: second_mentor) }
  let!(:second_mentor_assessment)    { ::Courses::Assessment.create(interview_assessment: second_interview_assessment, question: question, mark: rand(::Courses::Assessment::RANGE)) }

  describe '#call' do
    it 'calculates average assessment marks by question' do
      questions = [question]

      average_assessments = described_class.call(interview, questions)

      average_mark_for_question =
        average_assessments.select{|hsh| hsh[:question] == question.body}.first[:mark]

      expect(average_mark_for_question).to eq (first_mentor_assessment.mark+second_mentor_assessment.mark).to_f/2
    end
  end
end
