# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lecture UPDATE' do
  let(:season)  { create(:season, title: 'Test Season', status: :live) }
  let(:user)    { create(:user) }
  let(:mentor)  { create(:mentor, user: user, season: season) }

  before do
    create :lecture, title: 'Awesome lecture', mentor: mentor, season: season

    visit '/admin/courses/seasons/test-season/lectures/awesome-lecture/edit'
  end

  context 'when invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Update Lecture'

      expect_an_error lecture_title: :blank
    end
  end

  context 'when valid input' do
    it 'update season', :aggregate_failures do
      fill_in 'Title', with: 'Super Lecture'
      click_button 'Update Lecture'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/lectures'
      expect(page).to have_content 'Super Lecture'
    end
  end
end
