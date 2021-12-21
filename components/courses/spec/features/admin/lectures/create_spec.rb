# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture CREATE' do
  let!(:season)         { create(:season, title: 'Test Season', status: :live) }
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

    it 'validates errors when time is wrong' do
      select user.full_name, from: 'lecture[mentor_id]'
      select venue.name, from: 'lecture[venue_id]'
      fill_in 'Title', with: 'Awesome Lecture'
      click_button 'Create Lecture'

      expect(page).to have_content('must be after start time!')
    end
  end

  context 'valid input' do
    it 'creates lecture' do
      select user.full_name, from: 'lecture[mentor_id]'
      select venue.name, from: 'lecture[venue_id]'
      fill_in 'Title', with: 'Awesome lecture'
      pick_a_date 'lecture_finished_at', Time.current + 1.hour
      click_button 'Create Lecture'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/lectures'
      expect(page).to have_link 'Awesome lecture'
    end
  end
end
