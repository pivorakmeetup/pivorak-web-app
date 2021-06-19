# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Season CREATE' do
  before { visit '/admin/courses/seasons/new' }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Create Season'

      expect_an_error season_title: :blank
    end

    it 'validates errors when time is wrong' do
      fill_in 'Title', with: 'Super New Course Season'
      pick_a_date('season_start_at', Time.now + 60.days)
      pick_a_date('season_finish_at', Time.now)
      click_button 'Create Season'

      expect(page).to have_content('must be after start time!')
    end
  end

  context 'valid input' do
    it 'create new season' do
      fill_in 'Title', with: 'Super New Course Season'
      pick_a_date('season_start_at', Time.now)
      pick_a_date('season_finish_at', Time.now + 60.days)
      click_button 'Create Season'

      expect(page).to have_current_path '/admin/courses/seasons'
      expect(page).to have_content 'Super New Course Season'
    end
  end

  context 'open format' do
    it 'create new season' do
      fill_in 'Title', with: 'Super New Course Season'
      pick_a_date('season_start_at', Time.now)
      pick_a_date('season_finish_at', Time.now + 60.days)
      check 'Open format'
      click_button 'Create Season'

      expect(page).to have_current_path '/admin/courses/seasons'
      expect(page).to have_content 'Super New Course Season'
    end
  end
end
