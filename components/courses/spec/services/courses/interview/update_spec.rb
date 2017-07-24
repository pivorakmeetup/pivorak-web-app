require 'rails_helper'

describe Courses::Interview::Update do
  let!(:mentor)   { ::Courses::Mentor.create(user_id: 1, season_id: 1) }

  let(:interview) { create(:interview, mentor: mentor) }
  let(:student)   { create(:student, season_id: 1, user_id: 1, status: :enrolled) }

  describe '#call' do
    it 'updates interview' do
      Courses::Interview::Update.call(interview, student)

      expect(interview.student_id).to eq(student.id)
      expect(interview.status).to     eq('pending')
    end

    it 'changes status to interviewing for student' do
      Courses::Interview::Update.call(interview, student)

      expect(interview.student.status).to eq('interviewing')
    end
  end
end
