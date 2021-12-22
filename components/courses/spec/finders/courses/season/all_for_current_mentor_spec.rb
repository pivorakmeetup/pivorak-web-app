# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::AllForCurrentMentor do
  let(:season) { create(:season) }
  let(:user) { create(:user) }
  let!(:another_season) { create(:season) }

  describe '#call' do
    before do
      create(:mentor, user: user, season: season)
    end

    it 'returns available for current mentor seasons', :aggregate_failures do
      query = described_class.call(user)

      expect(query).to include(season)
      expect(query).not_to include(another_season)
    end
  end
end
