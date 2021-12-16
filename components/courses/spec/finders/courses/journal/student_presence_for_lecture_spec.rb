# frozen_string_literal: true

require 'rails_helper'

describe Courses::Journal::StudentPresenceForLecture do
  let!(:student) do
    ::Courses::Student.create(season_id: 1, user_id: 1, status: :attending,
                              personal_info: 'lorem', motivation_info: 'ipsum')
  end
  let!(:lecture)         { create(:lecture, title: 'awesome lecture', mentor_id: 1, venue_id: 1, season_id: 1) }
  let!(:first_progress)  do
    create(:progress,
           student: student, lecture: lecture, homework_mark: 1, lecture_presence: 0)
  end
  let!(:second_progress) { create(:progress, student: student, lecture_id: 3, homework_mark: -1, lecture_presence: -1) }

  describe '#call' do
    it 'gets student presence for the lecture' do
      real_presence = first_progress.lecture_presence

      presence = described_class.call(student, lecture)

      expect(presence).to eq(real_presence)
    end
  end
end
