require 'rails_helper'

RSpec.describe 'Lector CREATE' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { create(:user) }
  let!(:venue)          { create(:venue) }
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }

  before { visit '/admin/courses/seasons/test-season/lectures/new' }

  context 'invalid input' do
    it 'validates errors' do
      select user.full_name, from: 'lecture[mentor_id]'
      select venue.name, from: 'lecture[venue_id]'
      fill_in 'Title', with: ''
      click_button 'Create Lecture'

      expect_an_error lecture_title: :blank
    end
  end

  context 'valid input' do
    it 'creates lecture' do
      select user.full_name, from: 'lecture[mentor_id]'
      select venue.name, from: 'lecture[venue_id]'
      fill_in 'Title', with: 'Awesome lecture'
      click_button 'Create Lecture'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/lectures'
      expect(page).to have_link'Awesome lecture'
    end
  end
end
