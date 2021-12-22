# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Courses::Mentor::DestroyPolicy do
  let(:season) { create(:season, title: 'Test Season') }
  let(:user) { create(:user) }
  let(:mentor) { create :mentor, season: season }
  let!(:season_creator) { create :mentor, user: user, season: season }

  context 'when allow to destroy' do
    it 'allowed to destroy' do
      policy = described_class.new(mentor, season)

      expect(policy).to be_allowed
    end

    it 'not allowed to destroy' do
      policy = described_class.new(season_creator, season)

      expect(policy).not_to be_allowed
    end
  end
end
