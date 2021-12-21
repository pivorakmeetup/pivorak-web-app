# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::TimePolicy do
  describe '#allowed?' do
    context 'when start time is before finish time' do
      it 'allows to pass policy' do
        season = build(:season)
        policy = described_class.new(season)

        expect(policy).to be_allowed
      end
    end

    context 'when start time is nil' do
      it 'allows to pass policy' do
        season = build(:season, start_at: nil)
        policy = described_class.new(season)

        expect(policy).to be_allowed
      end
    end

    context 'when finish time is nil' do
      it 'allows to pass policy' do
        season = build(:season, finish_at: nil)
        policy = described_class.new(season)

        expect(policy).to be_allowed
      end
    end

    context 'when start time is after finish time' do
      it 'forbids to pass policy' do
        season = build(:season, finish_at: (Time.current - 100.days))
        policy = described_class.new(season)

        expect(policy).not_to be_allowed
      end
    end
  end
end
