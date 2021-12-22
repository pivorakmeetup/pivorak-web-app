# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::InterviewAssessmentForInterview do
  let(:season)                { create(:season, title: 'Test Season') }
  let(:user)                  { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:mentor)                { create(:mentor, user: user, season: season) }
  let!(:first_interview) { create(:interview, mentor: mentor) }
  let(:second_interview) { create(:interview, mentor: mentor, start_at: (Time.current + 1.hour)) }
  let!(:first_int_assessment) { create(:interview_assessment, interview: first_interview, mentor: mentor) }

  describe '#call' do
    before do
      create(:interview_assessment, interview: second_interview, mentor: mentor)
    end

    it 'gets interviews of the season' do
      int_assessment = described_class.call(first_interview, mentor)

      expect(int_assessment).to eq(first_int_assessment)
    end
  end
end
