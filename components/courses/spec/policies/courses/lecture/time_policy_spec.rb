require 'rails_helper'

describe Courses::Lecture::TimePolicy do
  describe '#allowed?' do
    context 'start time is before finish time' do
      it 'allows to pass policy' do
        lecture = build(:lecture)
        policy  = described_class.new(lecture)

        expect(policy.allowed?).to be_truthy
      end
    end

    context 'start time is after finish time' do
      it 'forbids to pass policy' do
        lecture = build(:lecture, finished_at: (Time.now - 100.days))
        policy  = described_class.new(lecture)

        expect(policy.allowed?).to be_falsey
      end
    end
  end
end
