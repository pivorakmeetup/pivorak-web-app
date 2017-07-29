require 'rails_helper'

RSpec.describe 'Students READ' do
  context 'displays list of students' do
    let!(:season)            { create(:season, title: 'Test Season', status: :registration) }
    let(:test_students_path) { '/admin/courses/seasons/test-season/students' }
    let!(:user_a)            { User.create(email: 'test_a@test.com', first_name: 'User', last_name: 'A') }
    let!(:user_b)            { User.create(email: 'test_b@test.com', first_name: 'User', last_name: 'B') }
    let!(:season_creator)    { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
    let!(:student_a)         { create(:student, personal_info: 'Student A', season_id: season.id, user_id: user_a.id, status: :enrolled) }
    let!(:student_b)         { create(:student, personal_info: 'Student B', season_id: season.id, user_id: user_b.id, status: :refused) }

    before { visit test_students_path }

    it 'displays list of students' do
      expect(page).to have_content student_a.personal_info
      expect(page).to have_content user_a.full_name
      expect(page).not_to have_content student_b.personal_info
      expect(page).not_to have_content user_b.full_name
    end
  end
end
