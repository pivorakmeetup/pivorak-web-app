require 'rails_helper'

RSpec.describe 'Interviews LIST' do
  let!(:season)    { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)    { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:student)   { create(:student, user_id: user.id, season_id: season.id, status: :test_task_done) }
  let!(:interview) { build(:interview, mentor_id: mentor.id) }

  context 'interviews are available' do
    it 'shows interview slots' do
      interview.student_id = nil
      interview.save
      visit '/courses/seasons/test-season/interviews/'

      expect(page).to have_content('Take')
    end
  end

  context 'no interviews available' do
    it 'does not show any interview slots' do
      interview.student_id = student.id
      interview.save

      visit '/courses/seasons/test-season/interviews/'
      expect(page).not_to have_content('Take')
    end
  end
end
