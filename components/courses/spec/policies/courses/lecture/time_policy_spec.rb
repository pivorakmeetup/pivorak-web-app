require 'rails_helper'

describe Courses::Lecture::TimePolicy do
  let(:lecture) { build(:lecture) }
  let(:policy)  { described_class.new(lecture) }

  describe '#allowed?' do
    context 'start time is before finish time' do
      it 'allows to pass policy' do
        expect(policy.allowed?).to be_truthy
      end
    end

    context 'start time is after finish time' do
      it 'forbids to pass policy' do
        lecture.finished_at = Time.now - 100.days

        expect(policy.allowed?).to be_falsey
      end
    end
  end
end
