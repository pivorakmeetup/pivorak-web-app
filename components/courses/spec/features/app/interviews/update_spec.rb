# frozen_string_literal: true

require 'rails_helper'

# TODO: Figure out why interviews list is empty
RSpec.xdescribe 'Interviews UPDATE' do
  let!(:season)    { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)      { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)    { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:student)   { create(:student, user_id: user.id, season_id: season.id, status: :test_task_done) }
  let!(:interview) { create(:interview, mentor_id: mentor.id, status: :vacant) }

  before { visit '/courses/seasons/test-season/interviews/' }

  context 'take first interview time slot' do
    it 'assigns student to interview' do
      click_link 'Take'
      interview.reload

      expect(interview.student_id).to eq(student.id)
      expect(interview.status).to     eq('pending')
    end
  end

  context 'take second interview time slot' do
    it 'does not assign student to interview' do
      create(:interview, mentor_id: mentor.id, student_id: student.id, start_at: (Time.current + 30.minutes))
      click_link 'Take'
      interview.reload

      expect(interview.student_id).not_to eq(student.id)
      expect(interview.status).to         eq('vacant')
    end
  end
end
