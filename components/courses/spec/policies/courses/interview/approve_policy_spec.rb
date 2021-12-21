# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::ApprovePolicy do
  let(:season)          { create(:season, title: 'Test Season', status: :selection) }
  let(:user)            { create(:user) }
  let!(:mentor)         { ::Courses::Mentor.create(user: user, season: season) }
  let!(:student)        { create(:student, season: season, user: user, status: :interviewing) }
  let(:interview)       { create(:interview, mentor: mentor, student: student, status: :completed) }

  let(:wrong_user)      { create(:user) }
  let(:wrong_interview) { create(:interview, mentor: mentor, student: student, status: :pending) }
  let(:wrong_student)   { create(:student, season: season, user: wrong_user, status: :graduated) }

  describe '#allowed?' do
    context 'when mentor allowed to approve student after interview' do
      it 'allows to pass policy' do
        policy = described_class.new(user, season, interview)
        expect(policy).to be_allowed
      end
    end

    context 'when current user is not interviewer' do
      it 'forbids to pass policy' do
        policy = described_class.new(wrong_user, season, interview)
        expect(policy).not_to be_allowed
      end
    end

    context 'when interview is not completed' do
      it 'forbids to pass policy' do
        policy = described_class.new(user, season, wrong_interview)
        expect(policy).not_to be_allowed
      end
    end

    context 'when status of student is not interviewing' do
      it 'forbids to pass policy' do
        interview.update(student_id: wrong_student.id)
        interview.reload

        policy = described_class.new(user, season, interview)
        expect(policy).not_to be_allowed
      end
    end
  end
end
