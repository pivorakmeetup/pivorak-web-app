# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Courses::Progress, type: :model do
  let!(:season)   { create(:season, title: 'Test Season') }
  let!(:user)     { create(:user) }
  let!(:venue)    { create(:venue) }
  let!(:mentor)   { ::Courses::Mentor.create(user: user, season: season) }
  let!(:lecture)  { create(:lecture, mentor: mentor, venue: venue, season: season) }
  let!(:student)  do
    ::Courses::Student.create(season: season, user: user, status: :attending,
                                              personal_info: 'lorem', motivation_info: 'ipsum')
  end
  let!(:progress) { ::Courses::Progress.create(student: student, lecture: lecture, mentor: mentor, homework_mark: 2) }

  describe 'validations' do
    it 'pass,s due to correct homework mark input' do
      ::Courses::Progress::ALLOWED_MARKS.each do |mark|
        progress.update_attributes(homework_mark: mark)
        expect(progress.valid?).to be true
      end
    end

    it 'fail,s due to bad homework mark input' do
      custom_marks = ::Courses::Progress::ALLOWED_MARKS
      max_mark = custom_marks.compact.max
      extended_bound = max_mark * 2
      arr_marks = ([*-extended_bound..extended_bound] - custom_marks).sample(max_mark)
      arr_marks.each do |mark|
        progress.update_attributes(homework_mark: mark)
        expect(progress.valid?).to be false
      end
    end
  end
end
