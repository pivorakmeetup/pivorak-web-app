require 'rails_helper'

describe Courses::Student::PlannedSeason do
  let!(:season)  { create(:season, status: :planned) }
  let!(:user)    { create(:user) }
  let!(:student) { create(:student, season: season, user: user) }

  describe '#call' do
    it 'returns an empty array' do
      query = described_class.call(season)

      expect(query).not_to include student
    end
  end
end
