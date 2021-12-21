# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::AllForCurrentMentor do
  let!(:season)         { create(:season) }
  let!(:another_season) { create(:season) }
  let!(:user)           { create(:user) }
  let!(:mentor)         { create(:mentor, user_id: user.id, season_id: season.id) }

  describe '#call' do
    it 'returns available for current mentor seasons', :aggregate_failures do
      query = described_class.call(user)

      expect(query).to include(season)
      expect(query).not_to include(another_season)
    end
  end
end
