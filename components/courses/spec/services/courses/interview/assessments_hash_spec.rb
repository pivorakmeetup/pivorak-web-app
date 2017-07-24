require 'rails_helper'

describe Courses::Interview::AssessmentsHash do
  let!(:season)            { create(:season, title: 'Test Season') }
  let!(:first_mentor)      { ::Courses::Mentor.create(user_id: 1, season_id: season.id) }
  let!(:second_mentor)     { ::Courses::Mentor.create(user_id: 2, season_id: season.id) }
  let!(:first_interview)   { create(:interview, mentor_id: first_mentor.id, season_id: season.id) }
  let!(:second_interview)  { create(:interview, mentor_id: first_mentor.id, season_id: season.id, start_at: Time.now + 1.hour) }
  let!(:first_question)    { create(:question, season_id: season.id) }
  let!(:second_question)   { create(:question, season_id: season.id) }
  let!(:first_assessment)  { ::Courses::InterviewAssessment.create(interview_id: first_interview.id, mentor_id: first_mentor.id, question_id: first_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:second_assessment) { ::Courses::InterviewAssessment.create(interview_id: first_interview.id, mentor_id: first_mentor.id, question_id: second_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:third_assessment)  { ::Courses::InterviewAssessment.create(interview_id: first_interview.id, mentor_id: second_mentor.id, question_id: first_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:fourth_assessment) { ::Courses::InterviewAssessment.create(interview_id: first_interview.id, mentor_id: second_mentor.id, question_id: second_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}

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
