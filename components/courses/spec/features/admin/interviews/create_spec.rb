# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Interview CREATE' do
  let!(:season)            { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)              { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)            { ::Courses::Mentor.create(user: user, season: season) }
  let!(:interview)         { create(:interview, mentor: mentor) }

  let(:new_interview_path) { '/admin/courses/seasons/test-season/interviews/new' }
  let(:date_field_name)    { 'interview_start_at' }

  before { visit new_interview_path }

  describe 'invalid input' do
    context 'blank start time' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)

        interview.start_at = ''

        expect(interview).not_to be_valid
      end
    end
  end

  context 'valid input' do
    it 'creates interview' do
      fill_in 'Description', with: 'Very hard interview'
      pick_a_date(date_field_name, Time.now + 40.minutes)
      select('vacant', from: 'Status')
      click_button 'Create Interview'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
      expect(page).to have_content 'vacant'
    end
  end
end
