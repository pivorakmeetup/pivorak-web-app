require 'rails_helper'

RSpec.describe 'Mentors LIST' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)         { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:another_user)   { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:another_mentor) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }


  context 'open existing page' do
    before { visit '/admin/courses/seasons/test-season/mentors/' }
    it { expect(page).to have_content(user.full_name) }
    it { expect(page).to have_content(another_user.full_name) }
  end
end
