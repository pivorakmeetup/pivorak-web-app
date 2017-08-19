require 'rails_helper'

RSpec.describe 'Test tasks UPDATE' do
  let!(:season)         { create(:season, title: 'Test Season', status: :registration) }
  let!(:user)           { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student)        { create(:student, season: season, user: user) }
  let!(:mentor)         { ::Courses::Mentor.create(user: user, season: season) }
  let!(:test_task)      { create(:test_task, student: student, mentor_id: nil) }
  let(:test_index_path) { '/admin/courses/seasons/test-season/test_task' }

  before { visit test_index_path }

  context 'test task is not approved' do
    it 'approves test task' do
      click_link 'Approve'

      expect(page).to have_content 'by Test User'
    end
  end
end
