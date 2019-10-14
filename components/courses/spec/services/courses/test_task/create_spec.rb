# frozen_string_literal: true

require 'rails_helper'

describe Courses::TestTask::Create do
  let!(:season)          { create(:season, title: 'Test Season') }
  let!(:user)            { create(:user) }
  let!(:student)         do
    ::Courses::Student.create(season_id: 1, user_id: 1, status: :enrolled,
                                                     personal_info: 'lorem', motivation_info: 'ipsum')
  end
  let(:test_task_params) do
    { git_url: Faker::Internet.url, showcase_url: Faker::Internet.url,
                             comment: Faker::Lorem.sentence }
  end

  describe '#call' do
    it 'creates test_task' do
      test_task = described_class.call(test_task_params, student)
      expect { test_task.save }.to change { ::Courses::TestTask.count }.by(1)
    end
  end
end
