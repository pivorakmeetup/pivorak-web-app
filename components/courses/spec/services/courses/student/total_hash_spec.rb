require 'rails_helper'

describe Courses::Student::TotalHash do
  let!(:first_student)   { ::Courses::Student.create(season_id: 1, user_id: 1, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum')  }
  let!(:second_student)  { ::Courses::Student.create(season_id: 1, user_id: 2, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum')  }
  let!(:first_progress)  { create(:progress, student: first_student, homework_mark: 1, lecture_presence: 0) }
  let!(:second_progress) { create(:progress, student: second_student, homework_mark: -1, lecture_presence: -1) }

  describe '#call' do
    it 'returns total hash' do
      students  = [first_student, second_student]

      total_hash = described_class.call(students)

      expect(total_hash[first_student]).to    eq(1)
      expect(total_hash[second_student]).to   eq(-2)
    end
  end
end
