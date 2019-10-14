# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homeworks INDEX for user' do
  let!(:season)  { create(:season, title: 'Test Season') }
  let!(:user)    { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)  { create :mentor, user: user, season: season }
  let!(:student) { create :student, season: season, user: user, status: :attending }

  let!(:first_lecture)   { create(:lecture, title: 'Awesome lecture', mentor: mentor, venue_id: 1, season: season) }
  let!(:second_lecture)  { create(:lecture, title: 'Cool lecture', mentor: mentor, venue_id: 1, season: season) }
  let!(:first_progress)  do
    create(:progress,
           student: student, lecture: first_lecture, homework_mark: 1, lecture_presence: 0)
  end
  let!(:second_progress) do
    create(:progress,
           student: student, lecture: second_lecture, homework_mark: -1, lecture_presence: -1)
  end

  let(:test_homeworks_path) { '/courses/seasons/test-season/homeworks' }

  before { visit test_homeworks_path }

  it 'displays journal correctly' do
    # shows first student first lecture mark
    within('td#l1_m') do
      expect(page).to have_content first_progress.homework_mark
    end

    # shows first student first lecture presence
    within('td#l1_p') do
      expect(page).to have_content ''
    end

    # shows first student second lecture mark
    within('td#l2_m') do
      expect(page).to have_content second_progress.homework_mark
    end

    # shows first student second lecture presence
    within('td#l2_p') do
      expect(page).to have_content second_progress.lecture_presence
    end
  end
end
