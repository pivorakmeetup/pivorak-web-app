# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentors LIST' do
  let(:season) { create(:season, title: 'Test Season', status: :planned) }
  let(:user) { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:another_user) { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }

  context 'when open existing page' do
    before do
      create :mentor, user: user, season: season
      create :mentor, user: another_user, season: season

      visit '/admin/courses/seasons/test-season/mentors/'
    end

    it { expect(page).to have_content(user.full_name) }
    it { expect(page).to have_content(another_user.full_name) }
  end
end
