require 'rails_helper'

describe Courses::Lecture::MentorsForLecture do
  let!(:season)         { create(:season) }
  let!(:mentor)         { create(:mentor, season_id: season.id) }
  let!(:another_mentor) { create(:mentor, season_id: season.id) }

  describe '#call' do
    it 'returns all mentors for lecture' do
      query = described_class.call(season)

      expect(query).to include(mentor, another_mentor)
    end
  end
end
