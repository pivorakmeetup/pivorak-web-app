# frozen_string_literal: true

require 'rails_helper'

describe Courses::Student::AttendingAndGraduated do
  let!(:season)         { create(:season) }
  let!(:another_season) { create(:season) }
  let!(:first_student)  { create(:student, user_id: 1,  season: season, status: :dropped) }
  let!(:second_student) { create(:student, user_id: 2,  season: season, status: :attending) }
  let!(:third_student)  { create(:student, user_id: 3,  season: season, status: :graduated) }
  let!(:fourth_student) { create(:student, user_id: 2,  season: another_season, status: :attending) }
  let!(:fifth_student)  { create(:student, user_id: 3,  season: another_season, status: :graduated) }

  describe '#call' do
    it 'returns attending and graduated students of the season' do
      query = described_class.call(season)

      expect(query).not_to include(first_student)
      expect(query).to     include(second_student)
      expect(query).to     include(third_student)
      expect(query).not_to include(fourth_student)
      expect(query).not_to include(fifth_student)
    end
  end
end
