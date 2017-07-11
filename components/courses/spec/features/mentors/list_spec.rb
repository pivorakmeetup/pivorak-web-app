require 'rails_helper'
require 'fixtures/fake_models/user'

RSpec.describe 'Mentors LIST' do
  let!(:season) { create(:season, title: 'Test Season') }
  let!(:user) { User.new(id: 1, first_name: 'Test', last_name: 'User') }
  let!(:mentor) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }


  context 'open existing page' do
    before { visit '/admin/courses/seasons/test-season/mentors/' }
    it { expect(page).to have_content('Test User') }
  end
end
