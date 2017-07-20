require 'rails_helper'

RSpec.describe 'Test_tasks LIST' do
  let!(:season)    { create(:season, title: 'Test Season') }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student)    { ::Courses::Student.create(student_id: student.id, season_id: season.id) }
  let!(:test_task) { create(:test_task, student_id: student.id, season_id: season.id) }

  context 'open existing page' do
    before { visit '/admin/courses/seasons/test-season/test_task/' }

    it { expect(page).to have_content(student.full_name) }
    it { expect(page).to have_content (git_url)}
    it { expect(page).to have_content (show_url)}
    it { expect (page).to have_content (comment)}
  end
end


