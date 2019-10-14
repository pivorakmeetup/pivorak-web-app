# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::ListPolicy do
  let!(:season)                 { create(:season, title: 'Test Season', status: :selection) }
  let!(:mentor)                 { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:student)                { create(:student, season_id: season.id, user_id: 1, status: :test_task_done) }
  let!(:another_season_student) { create(:student, season_id: 2, user_id: 2, status: :test_task_done) }
  let!(:another_status_student) { create(:student, season_id: season.id, user_id: 3, status: :enrolled) }
  let!(:test_task)              { create(:test_task, student_id: student.id, mentor_id: mentor.id) }

  describe '#allowed?' do
    context 'student belongs to this season and has approved test task' do
      it 'allows to pass policy' do
        policy = Courses::Interview::ListPolicy.new(student, season)
        expect(policy).to be_allowed
      end
    end

    context 'student does not belong to this season' do
      it 'forbids to pass policy' do
        policy = Courses::Interview::ListPolicy.new(another_season_student, season)
        expect(policy).to_not be_allowed
      end
    end

    context 'student has wrong status(not test_task_done)' do
      it 'forbids to pass policy' do
        policy = Courses::Interview::ListPolicy.new(another_status_student, season)
        expect(policy).to_not be_allowed
      end
    end
  end
end
