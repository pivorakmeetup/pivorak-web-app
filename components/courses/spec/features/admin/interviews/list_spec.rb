require 'rails_helper'

RSpec.describe 'Interviews LIST' do
  let!(:season)    { create(:season, title: 'Test Season') }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)    { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:interview) { create(:interview, mentor_id: mentor.id, season_id: season.id) }

  context 'open existing page' do
    before { visit '/admin/courses/seasons/test-season/interviews/' }

    it { expect(page).to have_content(mentor.full_name) }
  end
end
