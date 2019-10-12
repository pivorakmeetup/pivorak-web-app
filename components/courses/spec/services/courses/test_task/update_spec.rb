# frozen_string_literal: true

require 'rails_helper'

describe Courses::TestTask::Update do
  let!(:mentor)    { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:student)   { create(:student, season_id: 1, user_id: 1, status: :enrolled) }
  let!(:test_task) { create(:test_task, student_id: student.id, mentor_id: nil) }

  describe '#call' do
    it 'updates mentor_id' do
      described_class.call(test_task, mentor)

      expect(test_task.mentor_id).to eq(mentor.id)
    end

    it 'changes status to test_task_done for student' do
      described_class.call(test_task, mentor)

      expect(test_task.student.status).to eq('test_task_done')
    end
  end
end
