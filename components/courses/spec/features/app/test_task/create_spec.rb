require 'rails_helper'

RSpec.describe 'TestTask CREATE' do
  let!(:season)  { create(:season, title: 'Test Season', status: :registration) }
  let!(:user)    { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student) { create(:student, user_id: user.id, season_id: season.id) }
  let(:test_test_task_path) { '/courses/seasons/test-season/test_task/new' }

  before { visit test_test_task_path }

  describe 'valid input' do
    it 'create new test task' do
      fill_in 'Git url', with: 'https://github.com/test_student/homework_test'
      expect { click_button 'Create Test task' }.to change { ::Courses::TestTask.count }.by(1)
    end
  end
end
