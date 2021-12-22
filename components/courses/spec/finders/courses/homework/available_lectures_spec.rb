# frozen_string_literal: true

require 'rails_helper'

describe Courses::Homework::AvailableLectures do
  let(:season)          { create(:season) }
  let(:student)         { create(:student, season: season) }
  let(:lecture)         { create(:lecture, season: season) }
  let!(:another_lecture) { create(:lecture, season: season) }

  describe '#call' do
    before do
      create(:homework, lecture: lecture, student: student)
    end

    it 'returns lectures without homeworks', :aggregate_failures do
      query = described_class.call(season, student)

      expect(query).to include(another_lecture)
      expect(query).not_to include(lecture)
    end
  end
end
