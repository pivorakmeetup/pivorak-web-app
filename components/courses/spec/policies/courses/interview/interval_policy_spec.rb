# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::IntervalPolicy do
  let(:season)      { create(:season, title: 'Test Season') }
  let(:mentor)      { create(:mentor, season: season) }
  let(:interval)    { 30 }

  let(:policy) { described_class.new(mentor, interview, interval) }

  describe '#allowed?' do
    context 'when has no interviews in forbidden range' do
      let(:interview) { create(:interview, mentor_id: mentor.id) }

      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end

    context 'when has interviews 30 minutes prior' do
      let(:interview) { build_stubbed(:interview, mentor: mentor) }

      before do
        create(:interview, mentor: mentor, start_at: (Time.current - 20.minutes))
      end

      it 'forbids to pass policy' do
        expect(policy).not_to be_allowed
      end
    end

    context 'when has interviews 30 minutes after' do
      let(:interview) { build_stubbed(:interview, mentor: mentor) }

      before do
        create(:interview, mentor: mentor, start_at: (Time.current + 20.minutes))
      end

      it 'forbids to pass policy' do
        expect(policy).not_to be_allowed
      end
    end
  end
end
