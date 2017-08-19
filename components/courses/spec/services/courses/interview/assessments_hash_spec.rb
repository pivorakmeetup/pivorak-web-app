require 'rails_helper'

describe Courses::Interview::AssessmentsHash do
  let!(:season)                      { create(:season, title: 'Test Season') }
  let!(:first_mentor)                { ::Courses::Mentor.create(user_id: 1, season: season) }
  let!(:second_mentor)               { ::Courses::Mentor.create(user_id: 2, season: season) }
  let!(:first_interview)             { create(:interview, mentor: first_mentor) }
  let!(:second_interview)            { create(:interview, mentor: first_mentor, start_at: Time.now + 1.hour) }
  let!(:first_question)              { create(:question, season: season) }
  let!(:second_question)             { create(:question, season: season) }
  let!(:first_interview_assessment)  { ::Courses::InterviewAssessment.create(interview: first_interview, mentor: first_mentor) }
  let!(:first_assessment)            { ::Courses::Assessment.create(interview_assessment: first_interview_assessment, question: first_question, mark: rand(::Courses::Assessment::RANGE)) }
  let!(:second_assessment)           { ::Courses::Assessment.create(interview_assessment: first_interview_assessment, question: second_question, mark: rand(::Courses::Assessment::RANGE)) }
  let!(:second_interview_assessment) { ::Courses::InterviewAssessment.create(interview: first_interview, mentor: second_mentor) }
  let!(:third_assessment)            { ::Courses::Assessment.create(interview_assessment: second_interview_assessment, question: first_question, mark: rand(::Courses::Assessment::RANGE)) }
  let!(:fourth_assessment)           { ::Courses::Assessment.create(interview_assessment: second_interview_assessment, question: second_question, mark: rand(::Courses::Assessment::RANGE)) }

  describe '#call' do
    it 'returns assessments hash' do
      questions  = [first_question, second_question]
      interviews = [first_interview, second_interview]

      assessments_hash = described_class.call(interviews, questions)

      average_mark = (first_assessment.mark + second_assessment.mark +
        third_assessment.mark + fourth_assessment.mark)/4.0

      expect(assessments_hash[first_interview][:count]).to    eq(2)
      expect(assessments_hash[first_interview][:average]).to  eq(average_mark)
      expect(assessments_hash[second_interview][:count]).to   eq(0)
      expect(assessments_hash[second_interview][:average]).to eq(0.0)
    end
  end
end
