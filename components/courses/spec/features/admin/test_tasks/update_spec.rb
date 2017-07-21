require 'rails_helper'

RSpec.describe 'Test tasks UPDATE' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student)        { create(:student, season_id: season.id, user_id: user.id) }
  let!(:mentor)         { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:test_task)      { create(:test_task, student_id: student.id, mentor_id: nil) }
  let(:test_index_path) { '/admin/courses/seasons/test-season/test_task' }

  before { visit test_index_path }

  context 'test task is not approved' do
    it 'approves test task' do
      click_link 'Approve'

      expect(page).to have_content 'by Test User'
    end
  end
end
