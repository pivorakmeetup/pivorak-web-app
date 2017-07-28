require 'rails_helper'

describe Courses::Mentor::AvailableForMentoring do
  let!(:season)       { create(:season) }
  let!(:user)         { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:mentor)       { create(:mentor, user_id: user.id, season_id: season.id) }

  describe '#call' do
    it 'returns available for mentoring users' do
      query = described_class.call(season)

      expect(query).to include(another_user)
      expect(query).not_to include(user)
    end
  end
end
