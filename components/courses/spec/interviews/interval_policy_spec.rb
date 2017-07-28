require 'rails_helper'

describe Courses::Interview::IntervalPolicy do
  let!(:season)      { create(:season, title: 'Test Season') }
  let!(:mentor)      { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:interval)    { 30 }

  let(:policy) { Courses::Interview::IntervalPolicy.new(mentor, interview, interval) }

  describe '#allowed?' do
    context 'has no interviews in forbidden range' do
      let(:interview) { create(:interview, mentor_id: mentor.id) }

      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end

    context 'has interviews 30 minutes prior' do
      let(:interview) { build(:interview, mentor_id: mentor.id) }
      let!(:prev_interview) { create(:interview, mentor_id: mentor.id, start_at: (Time.now - 20.minutes)) }

      it 'forbids to pass policy' do
        expect(policy).to_not be_allowed
      end
    end

    context 'has interviews 30 minutes after' do
      let(:interview) { build(:interview, mentor_id: mentor.id) }
      let!(:next_interview) { create(:interview, mentor_id: mentor.id, start_at: (Time.now + 20.minutes)) }

      it 'forbids to pass policy' do
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
