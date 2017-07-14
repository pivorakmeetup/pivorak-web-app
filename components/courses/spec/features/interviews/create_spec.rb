require 'rails_helper'

RSpec.describe 'Interview CREATE' do
  let!(:season) { create(:season, title: 'Test Season') }
  let(:new_interview_path) { '/admin/courses/seasons/test-season/interviews/new' }
  let!(:user) { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor) { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }

  before { visit new_interview_path }

  context 'valid input' do
    it 'creates interview' do
      fill_in 'Description', with: 'Very hard interview'
      fill_in 'Start at', with: '01/04/2017'

      click_button 'Create Interview'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
      expect(page).to have_content(mentor.full_name)
    end
  end
end
