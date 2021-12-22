# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons READ' do
  context 'without any assignes' do
    let(:season_a)         { create(:season, title: 'Test Season A') }
    let(:user)             { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let(:season_b)         { create(:season, title: 'Test Season B') }

    before do
      create :mentor, user: user, season: season_a
      create :mentor, user: user, season: season_b
      visit '/admin/courses/seasons'
    end

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
