# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students READ' do
  context 'list of students' do
    let!(:season)            { create(:season, title: 'Test Season', status: :registration) }
    let(:test_students_path) { '/admin/courses/seasons/test-season/students' }
    let!(:user_a)            { User.create(email: 'test_a@test.com', first_name: 'User', last_name: 'A') }
    let(:user_b)             { User.create(email: 'test_b@test.com', first_name: 'User', last_name: 'B') }
    let!(:season_creator)    { ::Courses::Mentor.create(user: user_a, season: season) }
    let!(:student_a)         do
      create(:student,
             personal_info: 'Student A', season: season, user: user_a, status: :attending)
    end

    it 'displays list of students' do
      student_b = create(:student, personal_info: 'User B', season: season, user: user_b, status: :enrolled)
      visit test_students_path

      expect(page).not_to have_content student_a.personal_info
      expect(page).not_to have_content user_a.full_name
      expect(page).to have_content student_b.personal_info
      expect(page).to have_content user_b.full_name
    end

    it 'students registered first will be shown first' do
      student_recent = create(:student, user: create(:user, first_name: 'Recent', last_name: 'Student'), status: :enrolled)
      student_old = create(:student, user: create(:user, first_name: 'Old', last_name: 'Student') status: :enrolled, created_at: 1.week.ago)

      visit test_students_path

      expect(page).to have_tag('tr:first-child', text: 'Recent Student')
      expect(page).to have_tag('tr:last-child', text: 'Old Student')
    end

    it 'can drop bad students' do
      season.live!
      season.reload

      allow_any_instance_of(Courses::Student::DropPolicy).to receive(:allowed?).and_return(true)
      visit test_students_path

      click_link 'Drop!'

      expect(page).not_to have_content 'attending'
    end
  end
end
