# frozen_string_literal: true

require 'rails_helper'

describe Courses::TestTask::CreatePolicy do
  describe '#allowed?' do
    context 'when student has not sent test tasks' do
      let(:student) { build_stubbed(:student) }
      let(:season)  { build_stubbed(:season, title: 'Test Season') }

      it 'allows to pass policy' do
        policy = described_class.new(student, season)
        expect(policy.allowed?).to be(true)
      end
    end

    context 'when student has just sent test tasks' do
      let(:student) { create :student, season: season }
      let(:season)  { create :season, title: 'Test Season' }

      before do
        create :test_task, student: student
      end

      it 'forbids to pass policy' do
        policy = described_class.new(student, season)
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
