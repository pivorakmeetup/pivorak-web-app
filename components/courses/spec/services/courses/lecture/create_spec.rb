require 'rails_helper'

describe Courses::Lecture::Create do
  let!(:season)          { create(:season, title: 'Test Season') }
  let!(:user)            { create(:user) }
  let!(:another_user)    { create(:user) }
  let!(:venue)           { create(:venue) }
  let(:lecture)          { create(:lecture, mentor_id: 1, venue_id: 1, season_id: 1) }
  let!(:student)         { ::Courses::Student.create(season_id: 1, user_id: 1, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum') }
  let!(:another_student) { ::Courses::Student.create(season_id: 1, user_id: 2, status: :attending,
                                                      personal_info: 'lorem', motivation_info: 'ipsum') }
  describe '#call' do
    it 'creates lecture with attending students progress records' do
      described_class.call(lecture)

      expect(::Courses::Lecture.count).to eq(1)
      expect(lecture.progresses.count).to eq(2)
    end
  end
end
