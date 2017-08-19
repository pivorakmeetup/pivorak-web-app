require 'rails_helper'

RSpec.describe 'Journal SHOW' do
  let!(:season)          { create(:season, title: 'Test Season', status: :live) }
  let!(:user)            { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)          { ::Courses::Mentor.create(user: user, season: season) }

  let!(:second_user)     { User.create(email: 'second@test.com', first_name: 'Second', last_name: 'User') }
  let!(:third_user)      { User.create(email: 'third@test.com', first_name: 'Third', last_name: 'User') }

  let!(:first_lecture)   { create(:lecture, title: 'Awesome lecture', mentor: mentor, venue_id: 1, season: season) }
  let!(:second_lecture)  { create(:lecture, title: 'Cool lecture', mentor: mentor, venue_id: 1, season: season) }

  let!(:first_student)   { ::Courses::Student.create(season: season, user: second_user, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum')  }
  let!(:second_student)  { ::Courses::Student.create(season: season, user: third_user, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum')  }

  let!(:first_progress)  { create(:progress, student: first_student, lecture: first_lecture, homework_mark: 1, lecture_presence: 0) }
  let!(:second_progress) { create(:progress, student: second_student, lecture: first_lecture, homework_mark: 1, lecture_presence: -1) }
  let!(:third_progress)  { create(:progress, student: first_student, lecture: second_lecture, homework_mark: -1, lecture_presence: -1) }
  let!(:fourth_progress) { create(:progress, student: second_student, lecture: second_lecture, homework_mark: 0, lecture_presence: 0) }

  let(:test_j_path)      { '/admin/courses/seasons/test-season/journal' }

  before { visit test_j_path }

  it 'displays journal correctly' do
    # shows first student first lecture mark
      within('td#l1_s1_m.center.aligned') do
        expect(page).to have_content first_progress.homework_mark
      end

    # shows first student first lecture presence
      within('td#l1_s1_p.center.aligned') do
        expect(page).to have_content ''
      end

    #shows first student second lecture mark
    within('td#l2_s1_m.center.aligned') do
      expect(page).to have_content third_progress.homework_mark
    end

    # shows first student second lecture presence
    within('td#l2_s1_p.center.aligned') do
      expect(page).to have_content third_progress.lecture_presence
    end

    #shows first student total
    first_total = first_progress.homework_mark + first_progress.lecture_presence +
      third_progress.homework_mark + third_progress.lecture_presence

    within('td#s1_total.center.aligned') do
      expect(page).to have_content first_total
    end

    # shows second student first lecture mark
    within('td#l1_s2_m.center.aligned') do
      expect(page).to have_content first_progress.homework_mark
    end

    # shows second student first lecture presence
    within('td#l1_s2_p.center.aligned') do
      expect(page).to have_content second_progress.lecture_presence
    end

    # shows first student second lecture mark
    within('td#l2_s2_m.center.aligned') do
      expect(page).to have_content fourth_progress.homework_mark
    end

    # shows second student second lecture presence
    within('td#l2_s2_p.center.aligned') do
      expect(page).to have_content ''
    end

    #shows second student total
    second_total = second_progress.homework_mark + second_progress.lecture_presence +
      fourth_progress.homework_mark + fourth_progress.lecture_presence

    within('td#s2_total.center.aligned') do
      expect(page).to have_content second_total
    end
  end
end
