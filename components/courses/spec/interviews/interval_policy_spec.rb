require 'spec_helper'
require './app/policies/courses/interview/interval_policy.rb'

describe Courses::Interview::IntervalPolicy do
  let!(:season)      { create(:season, title: 'Test Season') }
  let!(:mentor)      { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:interval)    { 30 }

  describe '#allowed?' do
    context 'has no interviews in forbidden range' do
      it 'allows to pass policy' do
        interview = create(:interview, mentor_id: mentor.id)
        policy = Courses::Interview::IntervalPolicy.new(mentor, interview, interval)
        expect(policy.allowed?).to be(true)
      end
    end

    context 'has interviews 30 minutes prior' do
      it 'forbids to pass policy' do
        create(:interview, mentor_id: mentor.id, start_at: (Time.now - 20.minutes))
        interview = build(:interview, mentor_id: mentor.id)
        policy = Courses::Interview::IntervalPolicy.new(mentor, interview, interval)
        expect(policy.allowed?).to be(false)
      end
    end

    context 'has interviews 30 minutes after' do
      it 'forbids to pass policy' do
        create(:interview, mentor_id: mentor.id, start_at: (Time.now + 20.minutes))
        interview = build(:interview, mentor_id: mentor.id)
        policy = Courses::Interview::IntervalPolicy.new(mentor, interview, interval)
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
