# frozen_string_literal: true

require 'rails_helper'

describe Courses::Student::CreatePolicy do
  let(:user_id) { 1 }
  let(:season)  { create(:season, title: 'Test Season') }

  describe '#allowed?' do
    context 'when user has no applications' do
      it 'allows to pass policy' do
        policy = described_class.new(user_id, season)
        expect(policy.allowed?).to be(true)
      end
    end

    context 'when user has application' do
      before { create :student, season: season }

      it 'forbids to pass policy' do
        policy = described_class.new(user_id, season)
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
