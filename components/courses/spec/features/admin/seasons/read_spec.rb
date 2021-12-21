# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons READ' do
  context 'without any assignes' do
    let!(:season_a)         { create(:season, title: 'Test Season A') }
    let!(:user)             { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:season_a_creator) { ::Courses::Mentor.create(user: user, season_id: 1) }
    let!(:season_b)         { create(:season, title: 'Test Season B') }
    let!(:season_b_creator) { ::Courses::Mentor.create(user: user, season_id: 2) }

    before { visit '/admin/courses/seasons' }

    it 'displays list of seasons', :aggregate_failures do
      expect(page).to have_link 'Test Season A'
      expect(page).to have_link 'Test Season B'
    end

    it 'redirects to season#show', :aggregate_failures do
      click_link 'Test Season A'

      expect(page).to have_current_path '/admin/courses/seasons/test-season-a'
      expect(page).to have_content 'Test Season A'
    end
  end
end
