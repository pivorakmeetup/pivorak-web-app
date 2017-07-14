require 'rails_helper'

RSpec.describe 'Mentor CREATE' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { create(:user) }
  let!(:another_user)   { create(:user, first_name: 'Another') }
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }


  context 'valid input' do
    it 'creates mentor' do
      visit '/admin/courses/seasons/test-season/mentors/new'
      select 'User Another', from: 'mentor[user_id]'
      click_button 'Create Mentor'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/mentors'
      expect(page).to have_content 'Another User'
    end
  end
end
