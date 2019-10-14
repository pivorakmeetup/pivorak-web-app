# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::TimePolicy do
  describe '#allowed?' do
    context 'start time is before finish time' do
      it 'allows to pass policy' do
        season = build(:season)
        policy = described_class.new(season)

        expect(policy.allowed?).to be_truthy
      end
    end

    context 'start time is nil' do
      it 'allows to pass policy' do
        season = build(:season, start_at: nil)
        policy = described_class.new(season)

        expect(policy.allowed?).to be_truthy
      end
    end

    context 'finish time is nil' do
      it 'allows to pass policy' do
        season = build(:season, finish_at: nil)
        policy = described_class.new(season)

        expect(policy.allowed?).to be_truthy
      end
    end

    context 'start time is after finish time' do
      it 'forbids to pass policy' do
        season = build(:season, finish_at: (Time.now - 100.days))
        policy = described_class.new(season)

        expect(policy.allowed?).to be_falsey
      end
    end
  end
end
