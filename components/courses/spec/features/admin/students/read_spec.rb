# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students READ' do
  context 'list of students' do
    let!(:season) { create(:season, title: 'Test Season', status: :registration) }
    let(:test_students_path) { '/admin/courses/seasons/test-season/students' }
    let!(:user_a) { User.create(email: 'test_a@test.com', first_name: 'User', last_name: 'A') }
    let(:user_b) { User.create(email: 'test_b@test.com', first_name: 'User', last_name: 'B') }
    let!(:season_creator) { ::Courses::Mentor.create(user: user_a, season: season) }
    let!(:student_a) { create(:student, personal_info: 'Student A', season: season, user: user_a, status: :attending) }
    let(:mentor) { create(:mentor, user: user_b, season: season) }
    let(:lecture) { create(:lecture, mentor: mentor, venue: venue, season: season) }
    let(:venue) { create(:venue) }

    before do
      create(:progress, student: student_a, lecture: lecture, mentor: mentor, homework_mark: -1)
      create(:progress, student: student_a, lecture: lecture, mentor: mentor, homework_mark: -1)
      create(:progress, student: student_a, lecture: lecture, mentor: mentor, homework_mark: -1)
    end

    it 'displays list of students' do
      student_b = create(:student, personal_info: 'User B', season: season, user: user_b, status: :enrolled)
      visit test_students_path

      expect(page).not_to have_content student_a.personal_info
      expect(page).not_to have_content user_a.full_name
      expect(page).to have_content student_b.personal_info
      expect(page).to have_content user_b.full_name
    end

    # Q: What has been changed that we don't see students ?
    xit 'students registered first will be shown first' do
      create(:student, user: create(:user, first_name: 'Recent', last_name: 'Student'), status: :enrolled)
      create(:student,
             user:       create(:user, first_name: 'Old', last_name: 'Student'),
             status:     :enrolled,
             created_at: 1.week.ago)

      visit test_students_path

      expect(page).to have_css('tr:first-child', text: 'Recent Student')
      expect(page).to have_tag('tr:last-child', text: 'Old Student')
    end

    it 'can drop bad students' do
      season.live!
      season.reload

      visit test_students_path

      click_link 'Drop!'

      expect(page).not_to have_content 'attending'
    end
  end
end
