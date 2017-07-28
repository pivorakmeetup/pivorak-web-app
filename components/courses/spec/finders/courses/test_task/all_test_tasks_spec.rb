require 'rails_helper'

describe Courses::TestTask::AllTestTasks do
  let!(:season)           { create(:season, title: 'Test Season') }
  let!(:first_student)    { create(:student, season: season) }
  let!(:second_student)   { create(:student, season: season) }
  let(:first_test_task)   { create(:test_task, git_url: 'www.test_task.com', student: first_student) }
  let(:second_test_task)  { create(:test_task, git_url: 'www.test_task2.com', student: second_student) }

  describe '#call' do
    it 'gets test_tasks of the season' do
      correct_test_tasks = [first_test_task, second_test_task]

      test_tasks = described_class.call(season)

      expect(test_tasks).to eq(correct_test_tasks)
    end
  end
end
