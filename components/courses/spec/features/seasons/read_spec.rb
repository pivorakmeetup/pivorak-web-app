require 'rails_helper'

RSpec.describe 'Seasons READ' do
  context 'without any assignes' do
    let!(:season_a) { create(:season, title: 'Test Season A') }
    let!(:season_b) { create(:season, title: 'Test Season B') }

    before { visit '/admin/courses/seasons' }

    it 'displays list of seasons' do
      expect(page).to have_link 'Test Season A'
      expect(page).to have_link 'Test Season B'
    end

    it 'redirects to season#show' do
      click_link 'Test Season A'

      expect(page).to have_current_path '/admin/courses/seasons/test-season-a'
      expect(page).to have_content 'Test Season A'
    end
  end
end
