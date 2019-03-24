require 'rails_helper'

describe Courses::Lecture::Create do
  let!(:season)          { create(:season, title: 'Test Season') }
  let!(:user)            { create(:user) }
  let!(:another_user)    { create(:user) }
  let!(:venue)           { create(:venue) }
  let!(:mentor)          { create(:mentor) }
  let(:lecture)          { create(:lecture, mentor: mentor, venue: venue, season: season) }
  let!(:student)         { create :student, user: user, season: season, status: :attending }
  let!(:another_student) { create :student, user: another_user, season: season, status: :attending }

  describe '#call' do
    it 'creates lecture with attending students progress records' do
      described_class.call(lecture)

      expect(::Courses::Lecture.count).to eq(1)
      expect(lecture.progresses.count).to eq(2)
    end
  end
end
