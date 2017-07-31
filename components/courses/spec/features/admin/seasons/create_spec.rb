require 'rails_helper'

RSpec.describe 'Season CREATE' do

  before { visit '/admin/courses/seasons/new' }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Create Season'

      expect_an_error season_title: :blank
    end
  end

  context 'valid input' do
    it 'create new season' do
      fill_in 'Title', with: 'Super New Course Season'
      click_button 'Create Season'

      expect(page).to have_current_path '/admin/courses/seasons'
      expect(page).to have_content 'Super New Course Season'
    end
  end
end
