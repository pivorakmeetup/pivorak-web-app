# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons UPDATE' do
  let(:season)         { create(:season, title: 'Test Season') }
  let(:user)           { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:test_edit_path) { '/admin/courses/seasons/test-season/edit' }

  before do
    create(:mentor, user: user, season: season)

    visit test_edit_path
  end

  context 'when invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Update Season'

      expect_an_error season_title: :blank
    end
  end

  context 'when valid input' do
    it 'update season', :aggregate_failures do
      fill_in 'Title', with: 'Super New Season'
      click_button 'Update Season'

      expect(page).to have_current_path '/admin/courses/seasons'
      expect(page).to have_content 'Super New Season'
    end
  end
end
