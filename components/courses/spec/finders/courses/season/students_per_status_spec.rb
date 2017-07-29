require 'rails_helper'

describe Courses::Season::StudentsPerStatus do
  let(:season)          { create(:season, status: :planned) }
  let(:first_user)      { create(:user) }
  let(:second_user)     { create(:user) }
  let(:student)   { create(:student, user: first_user,  season: season, status: :enrolled) }
  let(:refused_student) { create(:student, user: second_user, season: season, status: :refused) }

  describe '#call' do
    it 'returns no students for planned season' do
      query = described_class.call(season)

      expect(query).to eq([])
    end

    it 'returns enrolled students for registration season' do
      season.update(status: :registration)

      query = described_class.call(season)

      expect(query).to     include student
      expect(query).not_to include refused_student
    end

    it 'returns students with test task done or interviewing status for selection season' do
      season.update(status: :selection)
      student.update(status: :interviewing)

      query = described_class.call(season)

      expect(query).to     include student
      expect(query).not_to include refused_student
    end

    it 'returns attending students for live season' do
      season.update(status: :live)
      student.update(status: :attending)

      query = described_class.call(season)

      expect(query).to     include student
      expect(query).not_to include refused_student
    end

    it 'returns graduated students for passed season' do
      season.update(status: :passed)
      student.update(status: :graduated)

      query = described_class.call(season)

      expect(query).to     include student
      expect(query).not_to include refused_student
    end
  end
end
