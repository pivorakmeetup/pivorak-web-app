require 'rails_helper'

describe Courses::Journal::Total do
  let!(:student)         { ::Courses::Student.create(season_id: 1, user_id: 1, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum') }
  let!(:first_progress)  { create(:progress, student: student, homework_mark: 1, lecture_presence: 0) }
  let!(:second_progress) { create(:progress, student: student, homework_mark: 1, lecture_presence: -1) }

  describe '#call' do
    it 'counts total of homework marks and presence marks' do
      total = described_class.call(student)
      marks_sum = first_progress.homework_mark + second_progress.homework_mark +
        first_progress.lecture_presence + second_progress.lecture_presence

      expect(total).to eq(marks_sum)
    end
  end
end
