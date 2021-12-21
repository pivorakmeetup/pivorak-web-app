# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor CREATE' do
  let!(:season)         { create(:season, title: 'Test Season', status: :planned) }
  let!(:user)           { create(:user) }
  let!(:another_user)   { create(:user, first_name: 'Another') }
  let!(:season_creator) { ::Courses::Mentor.create(user: user, season: season) }

  before { visit '/admin/courses/seasons/test-season/mentors/new' }

  context 'when valid input' do
    it 'creates mentor', :aggregate_failures do
      select 'User Another', from: 'mentor[user_id]'
      click_button 'Create Mentor'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/mentors'
      expect(page).to have_content 'Another User'
    end
  end

  describe 'drop down' do
    it 'has no name of already existing mentor' do
      expect(page).to have_no_content 'User Test'
    end
  end
end
