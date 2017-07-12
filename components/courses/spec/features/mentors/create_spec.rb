require 'rails_helper'

RSpec.describe 'Mentor CREATE' do
  let!(:season) { create(:season, title: 'Test Season') }
  let!(:user) { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:new_mentor_path) { '/admin/courses/seasons/test-season/mentors/new' }

  before { visit new_mentor_path }

  context 'valid input' do
    it 'creates mentor' do
      select user.reverse_full_name, from: 'mentor[user_id]'
      click_button 'Create Mentor'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/mentors'
      expect(page).to have_content 'Test User'
    end
  end
end
