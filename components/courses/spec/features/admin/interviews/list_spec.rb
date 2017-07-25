require 'rails_helper'

RSpec.describe 'Interviews LIST' do
  let!(:season)    { create(:season, title: 'Test Season') }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student)   { create(:student, user_id: user.id, season_id: season.id, status: :interviewing) }
  let!(:mentor)    { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:interview) { create(:interview, mentor_id: mentor.id, season_id: season.id,
                                 student_id: student.id, status: :completed) }

  before { visit '/admin/courses/seasons/test-season/interviews/' }

  context 'open existing page' do

    it { expect(page).to have_content(mentor.full_name) }
  end

  context 'interview approve' do
    it 'approves student' do
      click_link 'Approve'

      expect(page).to have_content 'Approved'
      expect(::Courses::Student.last.status).to eq('attending')
    end
  end
end
