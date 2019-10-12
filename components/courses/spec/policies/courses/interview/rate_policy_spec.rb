# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::RatePolicy do
  let!(:season)      { create(:season, title: 'Test Season') }
  let!(:student)     { create(:student, status: :interviewing) }
  let!(:mentor)      { ::Courses::Mentor.create(user_id: 1, season_id: 1) }

  describe '#allowed?' do
    context 'has student, video url & is completed' do
      let(:interview) do
        create(:interview,
               mentor_id: mentor.id, status: :completed, student_id: student.id, video_url: 'some url')
      end
      let(:policy) { described_class.new(interview) }

      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end
  end

  describe 'not allowed?' do
    context 'interview has no student' do
      let(:interview) { create(:interview, mentor_id: mentor.id, status: :completed, video_url: 'some url') }
      let(:policy) { described_class.new(interview) }

      it 'allows to pass policy' do
        expect(policy).not_to be_allowed
      end
    end

    context 'interview has no video url' do
      let(:interview) { create(:interview, mentor_id: mentor.id, status: :completed, student_id: student.id) }
      let(:policy) { described_class.new(interview) }

      it 'allows to pass policy' do
        expect(policy).not_to be_allowed
      end
    end

    context 'interview is not completed' do
      let(:interview) do
        create(:interview,
               mentor_id: mentor.id, status: :pending, student_id: student.id, video_url: 'some url')
      end
      let(:policy) { described_class.new(interview) }

      it 'allows to pass policy' do
        expect(policy).not_to be_allowed
      end
    end
  end
end
