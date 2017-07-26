require 'rails_helper'

RSpec.describe 'Test tasks LIST' do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:another_user)   { User.create(email: 'user@test.com', first_name: 'Another', last_name: 'User') }
  let!(:student)        { create(:student, season_id: season.id, user_id: user.id) }
  let!(:mentor)         { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:another_mentor) { ::Courses::Mentor.create(user_id: another_user.id, season_id: season.id) }
  let!(:test_task)      { create(:test_task, student_id: student.id, mentor_id: another_mentor.id) }
  let(:test_index_path) { '/admin/courses/seasons/test-season/test_task' }

  before { visit test_index_path }

  context 'shows test task list with correct mentor' do
    it { expect(page).to have_content 'by Another User' }
  end
end
