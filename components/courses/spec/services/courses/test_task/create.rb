require 'rails_helper'

describe Courses::TestTask::Create do
  let(:test_task_params)       { { git_url: Faker::Internet.url, showcase_url: Faker::Internet.url,
                         description: Faker::Lorem.sentence } }
  let(:student_id)   { 1 }

  describe '#call' do
    it 'creates test_task' do
      test_task = described_class.call(test_task_params, student_id)
      expect { test_task.save }.to change { ::Courses::Homework.count }.by(1)
    end

    it 'creates homework with correct student_id' do
      test_task = described_class.call(test_task_params, student_id)
      test_task.save

      expect(test_task.student_id).to eq(student_id)
    end
  end
end
