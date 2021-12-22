# frozen_string_literal: true

require 'rails_helper'

describe Courses::Lecture::TimePolicy do
  let(:lecture) { build(:lecture) }
  let(:policy)  { described_class.new(lecture) }

  describe '#allowed?' do
    context 'when start time is before finish time' do
      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end

    context 'when start time is after finish time' do
      it 'forbids to pass policy' do
        lecture.finished_at = Time.current - 100.days

        expect(policy).not_to be_allowed
      end
    end
  end
end
