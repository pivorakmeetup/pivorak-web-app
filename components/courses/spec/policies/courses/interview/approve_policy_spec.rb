require 'rails_helper'

describe Courses::Interview::ApprovePolicy do
  let(:season)      { create(:season, title: 'Test Season', status: :selection) }
  let(:user)        { create(:user) }
  let!(:mentor)     { ::Courses::Mentor.create(user: user, season: season) }
  let!(:student)    { create(:student, season: season, user: user, status: :interviewing) }
  let(:interview)   { create(:interview, mentor: mentor, student: student, status: :completed) }

  let(:wrong_user)  { create(:user) }
  let(:w_interview) { create(:interview, mentor: mentor, student: student, status: :pending) }
  let(:w_student)  { create(:student, season: season, user: wrong_user, status: :graduated) }

  describe '#allowed?' do
    context 'mentor allowed to approve student after interview' do
      it 'allows to pass policy' do
        policy = described_class.new(user, season, interview)
        expect(policy).to be_allowed
      end
    end

    context 'current user is not interviewer' do
      it 'forbids to pass policy' do
        policy = described_class.new(wrong_user, season, interview)
        expect(policy).not_to be_allowed
      end
    end

    context 'interview is not completed' do
      it 'forbids to pass policy' do
        policy = described_class.new(user, season, w_interview)
        expect(policy).not_to be_allowed
      end
    end

    context 'status of student is not interviewing' do
      it 'forbids to pass policy' do
        interview.update(student_id: w_student.id)
        interview.reload

        policy = described_class.new(user, season, interview)
        expect(policy).not_to be_allowed
      end
    end
  end
end
