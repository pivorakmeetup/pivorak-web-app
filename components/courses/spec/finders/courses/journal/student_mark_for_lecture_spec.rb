# frozen_string_literal: true

require 'rails_helper'

describe Courses::Journal::StudentMarkForLecture do
  let(:student) { create(:student, status: :attending, personal_info: 'lorem', motivation_info: 'ipsum') }
  let(:lecture) { create(:lecture, title: 'awesome lecture') }
  let!(:first_progress) do
    create(:progress, student: student, lecture: lecture, homework_mark: 1, lecture_presence: 0)
  end

  describe '#call' do
    before do
      create(:progress, student: student, homework_mark: -1, lecture_presence: -1)
    end

    it 'gets student mark for the lecture' do
      real_mark = first_progress.homework_mark

      mark = described_class.call(student, lecture)

      expect(mark).to eq(real_mark)
    end
  end
end
