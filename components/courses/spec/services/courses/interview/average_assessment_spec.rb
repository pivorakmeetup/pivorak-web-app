require 'rails_helper'

describe Courses::Interview::AverageAssessment do
  let!(:season)            { create(:season, title: 'Test Season') }
  let!(:first_mentor)      { ::Courses::Mentor.create(user_id: 1, season_id: season.id) }
  let!(:second_mentor)     { ::Courses::Mentor.create(user_id: 2, season_id: season.id) }
  let!(:interview)         { create(:interview, mentor_id: first_mentor.id, season_id: season.id) }
  let!(:first_question)    { create(:question, season_id: season.id) }
  let!(:second_question)   { create(:question, season_id: season.id) }
  let!(:first_assessment)  { ::Courses::InterviewAssessment.create(interview_id: interview.id, mentor_id: first_mentor.id, question_id: first_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:second_assessment) { ::Courses::InterviewAssessment.create(interview_id: interview.id, mentor_id: first_mentor.id, question_id: second_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:third_assessment)  { ::Courses::InterviewAssessment.create(interview_id: interview.id, mentor_id: second_mentor.id, question_id: first_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}
  let!(:fourth_assessment) { ::Courses::InterviewAssessment.create(interview_id: interview.id, mentor_id: second_mentor.id, question_id: second_question.id, mark: rand(::Courses::InterviewAssessment::RANGE))}

  describe '#call' do
    it 'calculates average assessment marks by question' do
      questions = [first_question, second_question]

      average_assessments = described_class.call(interview, questions)

      average_mark_for_first_question =
        average_assessments.select{|hsh| hsh[:question] == first_question.body}.first[:mark]
      average_mark_for_second_question =
        average_assessments.select{|hsh| hsh[:question] == second_question.body}.first[:mark]

      expect(average_mark_for_first_question).to eq (first_assessment.mark+third_assessment.mark).to_f/2
      expect(average_mark_for_second_question).to eq (second_assessment.mark+fourth_assessment.mark).to_f/2
    end
  end
end
