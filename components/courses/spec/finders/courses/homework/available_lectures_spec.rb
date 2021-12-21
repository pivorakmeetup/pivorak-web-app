# frozen_string_literal: true

require 'rails_helper'

describe Courses::Homework::AvailableLectures do
  let!(:season)          { create(:season) }
  let!(:lecture)         { create(:lecture, venue_id: 1, season_id: season.id, mentor_id: 1) }
  let!(:another_lecture) { create(:lecture, venue_id: 1, season_id: season.id, mentor_id: 1) }
  let!(:student)         { create(:student, season_id: 1) }
  let!(:homework)        { create(:homework, lecture_id: lecture.id, student_id: student.id) }

  describe '#call' do
    it 'returns lectures without homeworks', :aggregate_failures do
      query = described_class.call(season, student)

      expect(query).to include(another_lecture)
      expect(query).not_to include(lecture)
    end
  end
end
