require 'rails_helper'

RSpec.xdescribe 'Interview CREATE' do
  let!(:season)            { create(:season, title: 'Test Season') }
  let(:new_interview_path) { '/admin/courses/seasons/test-season/interviews/new' }
  let!(:user)              { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)            { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:interview)         { create(:interview, mentor_id: mentor.id) }

  before { visit new_interview_path }

  describe 'invalid input' do
    context 'blank start time' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)

        fill_in "Start at",  with: ''
        click_button 'Create Interview'

        expect_an_error interview_start_at: :blank
      end
    end

    context 'invalid interval' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(false)
        fill_in 'Start at',  with: (Time.now + 20.minutes).to_s
        click_button 'Create Interview'

        expect_an_error interview_start_at: 'should be at least 30 minutes between interviews'
      end
    end
  end

  context 'valid input' do
    it 'creates interview' do
      fill_in 'Description', with: 'Very hard interview'
      fill_in 'Start at', with: (Time.now + 40.minutes).to_s
      select('vacant', from: 'Status')
      click_button 'Create Interview'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
      expect(page).to have_content 'vacant'
    end
  end
end
