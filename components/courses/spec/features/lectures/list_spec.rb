require 'rails_helper'

RSpec.describe 'Lectures LIST' do
  let!(:season)          { create(:season, title: 'Test Season') }
  let!(:user)            { create(:user) }
  let!(:venue)           { create(:venue) }
  let!(:season_creator)  { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:lecture)         { create(:lecture, mentor_id: 1, venue_id: 1, season_id: 1) }
  let!(:another_lecture) { create(:lecture, mentor_id: 1, venue_id: 1, season_id: 1) }


  context 'open existing page' do
    before { visit '/admin/courses/seasons/test-season/lectures/' }
    it { expect(page).to have_content(lecture.title) }
    it { expect(page).to have_content(another_lecture.title) }
  end
end
