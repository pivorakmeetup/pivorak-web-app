# frozen_string_literal: true

require 'rails_helper'

describe Courses::TestTask::CreatePolicy do
  let(:student) { create(:student) }
  let(:season)  { create(:season, title: 'Test Season') }

  describe '#allowed?' do
    context 'student has not sent test tasks' do
      it 'allows to pass policy' do
        policy = Courses::TestTask::CreatePolicy.new(student, season)
        expect(policy.allowed?).to be(true)
      end
    end

    context 'student has just sent test tasks' do
      it 'forbids to pass policy' do
        allow(season).to receive_message_chain(:test_tasks, :exists?).and_return(true)
        policy = Courses::TestTask::CreatePolicy.new(student, season)
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
