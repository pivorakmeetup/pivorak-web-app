require 'rails_helper'

RSpec.describe 'Students READ' do
  context 'displays list of students' do
    let!(:season)            { create(:season, title: 'Test Season') }
    let(:test_students_path) { '/admin/courses/seasons/test-season/students' }
    let!(:user_a)            { User.create(email: 'test_a@test.com', first_name: 'Test', last_name: 'User') }
    let!(:user_b)            { User.create(email: 'test_b@test.com', first_name: 'Test', last_name: 'User') }
    let!(:season_creator)    { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
    let!(:student_a)         { create(:student, personal_info: 'Student A', season_id: season.id, user_id: user_a.id) }
    let!(:student_b)         { create(:student, personal_info: 'Student B', season_id: season.id, user_id: user_b.id) }

    before { visit test_students_path }

    it 'displays list of students' do
      expect(page).to have_content 'Student A'
      expect(page).to have_content user_a.full_name
      expect(page).to have_content 'Student B'
      expect(page).to have_content user_b.full_name
    end
  end
end
