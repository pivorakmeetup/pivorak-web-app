require 'rails_helper'

describe Courses::Student::LiveSeason do
  let!(:season)            { create(:season, status: :live) }
  let!(:first_user)        { create(:user) }
  let!(:second_user)       { create(:user) }
  let!(:third_user)        { create(:user) }
  let!(:attending_student) { create(:student, season: season, user: first_user,  status: :attending) }
  let!(:dropped_student)   { create(:student, season: season, user: second_user, status: :dropped) }
  let!(:refused_student)   { create(:student, season: season, user: third_user,  status: :refused) }

  describe '#call' do
    it 'returns all attending season students' do
      query = described_class.call(season)

      expect(query).to     include attending_student
      expect(query).not_to include dropped_student
      expect(query).not_to include refused_student
    end
  end
end
