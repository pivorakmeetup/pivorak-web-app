# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor access' do
  let(:season)         { create(:season, title: 'Test Season') }
  let(:user)           { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }

  before do
    create :mentor, user: user, season: season
    create(:season, title: 'Another Season')
  end

  context 'when mentor allowed' do
    it 'allow access' do
      visit '/admin/courses/seasons/test-season'
      expect(page).to have_current_path '/admin/courses/seasons/test-season'
    end
  end

  context 'when mentor not allowed' do
    it 'reject response' do
      visit '/admin/courses/seasons/another-season'
      expect(page).to have_current_path '/admin/courses/seasons'
    end
  end
end
