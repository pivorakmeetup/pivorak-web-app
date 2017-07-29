require 'rails_helper'

describe Courses::Student::PassedSeason do
  let!(:season)            { create(:season, status: :passed) }
  let!(:first_user)        { create(:user) }
  let!(:second_user)       { create(:user) }
  let!(:third_user)        { create(:user) }
  let!(:graduated_student) { create(:student, season: season, user: first_user,  status: :graduated) }
  let!(:dropped_student)   { create(:student, season: season, user: second_user, status: :dropped) }
  let!(:attending_student) { create(:student, season: season, user: third_user,  status: :attending) }

  describe '#call' do
    it 'returns all graduated season students' do
      query = described_class.call(season)

      expect(query).to     include graduated_student
      expect(query).not_to include dropped_student
      expect(query).not_to include attending_student
    end
  end
end
