require 'rails_helper'

describe Courses::Interview::AllInterviews do
  let!(:season)           { create(:season, title: 'Test Season') }
  let!(:user)             { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)           { ::Courses::Mentor.create(user: user, season: season) }
  let!(:another_mentor)   { ::Courses::Mentor.create(user: user, season_id: 2) }
  let!(:first_interview)  { create(:interview, mentor: mentor, season_id: season.id) }
  let!(:second_interview) { create(:interview, mentor: mentor, season_id: season.id, start_at: (Time.now + 1.hour)) }
  let!(:third_interview)  { create(:interview, mentor: another_mentor, season_id: 2, start_at: (Time.now + 2.hour)) }

  describe '#call' do
    it 'gets interviews of the season' do
      correct_interviews = [first_interview, second_interview]

      interviews = described_class.call(season)

      expect(interviews).to eq(correct_interviews)
    end
  end
end
