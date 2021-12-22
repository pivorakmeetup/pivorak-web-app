# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TestTask SUBMIT' do
  let(:season)  { create(:season, title: 'Test Season', status: :registration) }
  let(:user)    { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }

  let(:test_test_task_path) { '/courses/seasons/test-season/test_task/new' }

  before do
    create(:student, user: user, season: season)

    visit test_test_task_path
  end

  describe 'new test task' do
    it 'creates new test task' do
      fill_in 'Git url', with: 'https://github.com/test_student/homework_test'
      expect { click_button 'Submit' }.to change { ::Courses::TestTask.count }.by(1)
    end
  end
end
