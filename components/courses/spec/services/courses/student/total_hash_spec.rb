require 'rails_helper'

describe Courses::Student::TotalHash do
  let!(:user_a)          { User.create(email: 'test_a@test.com', first_name: 'A', last_name: 'User') }
  let!(:user_b)          { User.create(email: 'test_b@test.com', first_name: 'B', last_name: 'User') }
  let!(:first_lecture)   { create(:lecture, mentor_id: 1, venue_id: 1, season_id: 1) }
  let!(:second_lecture)  { create(:lecture, mentor_id: 1, venue_id: 1, season_id: 1) }
  let(:first_student)    { create(:student, season_id: 1, user: user_b, status: :attending) }
  let(:second_student)   { create(:student, season_id: 1, user: user_a, status: :attending) }
  let!(:first_progress)  { create(:progress, student: first_student, lecture: first_lecture, homework_mark: 2, lecture_presence: -1) }
  let!(:second_progress) { create(:progress, student: second_student, lecture: first_lecture, homework_mark: 1.5, lecture_presence: 0) }
  let!(:third_progress)  { create(:progress, student: first_student, lecture: second_lecture, homework_mark: -1, lecture_presence: 1) }
  let!(:fourth_progress) { create(:progress, student: second_student, lecture: second_lecture, homework_mark: 1, lecture_presence: 0) }

  describe '#call' do
    it 'returns total hash' do
      students          = [first_student, second_student]

      first_total       = first_progress.homework_mark + first_progress.lecture_presence +
        third_progress.homework_mark + third_progress.lecture_presence
      second_total      = second_progress.homework_mark + second_progress.lecture_presence +
        fourth_progress.homework_mark + fourth_progress.lecture_presence

      first_progresses  = [first_progress, third_progress]
      second_progresses = [second_progress, fourth_progress]

      total_hash        = described_class.call(students)

      expect(total_hash[first_student][:total]).to        eq(first_total)
      expect(total_hash[second_student][:total]).to       eq(second_total)
      expect(total_hash[first_student][:per_lecture]).to  eq(first_progresses)
      expect(total_hash[second_student][:per_lecture]).to eq(second_progresses)
    end

    it 'sorts hash by name by default' do
      students   = [first_student, second_student]
      name       = user_a.full_name

      total_hash = described_class.call(students)

      expect(total_hash.keys[0].full_name).to eq(name)
    end

    it 'sorts hash by total' do
      students   = [first_student, second_student]
      total      = second_progress.homework_mark + second_progress.lecture_presence +
        fourth_progress.homework_mark + fourth_progress.lecture_presence

      total_hash = described_class.call(students, sort_by: 'total')

      expect(total_hash.values[0][:total]).to eq(total)
    end

    it 'sorts hash by name' do
      students   = [first_student, second_student]
      name       = user_a.full_name

      total_hash = described_class.call(students, sort_by: 'name')

      expect(total_hash.keys[0].full_name).to eq(name)
    end

    it 'sorts hash by lecture marks' do
      students     = [first_student, second_student]
      highest_mark = first_progress.homework_mark

      total_hash = described_class.call(students, sort_by: 'lecture', lecture_id: first_lecture.id)

      expect(total_hash.values[0][:per_lecture][0].homework_mark).to eq(highest_mark)
    end
  end
end
