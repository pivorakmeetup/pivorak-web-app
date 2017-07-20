require 'rails_helper'

RSpec.describe 'Seasons UPDATE' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let(:test_edit_path)  { '/admin/courses/seasons/test-season/edit' }

  before { visit test_edit_path }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Update Season'

      expect_an_error season_title: :blank
    end
  end

  context 'valid input' do
    it 'update season' do
      fill_in 'Title',  with: 'Super New Season'
      click_button 'Update Season'

      expect(page).to have_current_path '/admin/courses/seasons'
      expect(page).to have_content 'Super New Season'
    end
  end
end
