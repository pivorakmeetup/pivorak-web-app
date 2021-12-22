# frozen_string_literal: true

require 'rails_helper'

describe Courses::Mentor::AvailableForMentoring do
  let(:season)       { create(:season) }
  let(:user)         { create(:user) }
  let!(:another_user) { create(:user) }

  describe '#call' do
    before do
      create(:mentor, user: user, season: season)
    end

    it 'returns available for mentoring users', :aggregate_failures do
      query = described_class.call(season)

      expect(query).to include(another_user)
      expect(query).not_to include(user)
    end
  end
end
