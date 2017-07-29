require 'rails_helper'

describe Courses::Student::SelectionSeason do
  let!(:season)                 { create(:season, status: :selection) }
  let!(:first_user)             { create(:user) }
  let!(:second_user)            { create(:user) }
  let!(:third_user)             { create(:user) }
  let!(:interviewing_student)   { create(:student, season: season, user: first_user,  status: :interviewing) }
  let!(:test_task_done_student) { create(:student, season: season, user: second_user, status: :test_task_done) }
  let!(:attending_student)      { create(:student, season: season, user: third_user,  status: :attending) }

  describe '#call' do
    it 'returns all interviewing & test task done season students' do
      query = described_class.call(season)

      expect(query).to     include test_task_done_student
      expect(query).to     include interviewing_student
      expect(query).not_to include attending_student
    end
  end
end
