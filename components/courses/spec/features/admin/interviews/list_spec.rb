# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Interviews LIST' do
  let!(:season)    { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student)   { create(:student, user: user, season: season, status: :interviewing) }
  let!(:mentor)    { ::Courses::Mentor.create(user: user, season: season) }
  let!(:interview) { create(:interview, mentor: mentor, season_id: season.id, student: student, status: :completed) }

  before { visit '/admin/courses/seasons/test-season/interviews/' }

  context 'open existing page' do
    it { expect(page).to have_content(mentor.full_name) }
  end

  context 'interview approve' do
    it 'approves student' do
      click_link 'Approve'

      expect(::Courses::Student.last.status).to eq('attending')
    end
  end
end
