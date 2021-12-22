# frozen_string_literal: true

require 'rails_helper'

describe Courses::Interview::ListPolicy do
  let(:season)                 { create(:season, title: 'Test Season', status: :selection) }
  let(:mentor)                 { create(:mentor, season: season) }
  let(:student)                { create(:student, season: season, status: :test_task_done) }
  let!(:another_season_student) { create(:student, status: :test_task_done) }
  let!(:another_status_student) { create(:student, season: season, status: :enrolled) }

  describe '#allowed?' do
    before do
      create(:test_task, student: student, mentor: mentor)
    end

    context 'when student belongs to this season and has approved test task' do
      it 'allows to pass policy' do
        policy = described_class.new(student, season)
        expect(policy).to be_allowed
      end
    end

    context 'when student does not belong to this season' do
      it 'forbids to pass policy' do
        policy = described_class.new(another_season_student, season)
        expect(policy).not_to be_allowed
      end
    end

    context 'when student has wrong status(not test_task_done)' do
      it 'forbids to pass policy' do
        policy = described_class.new(another_status_student, season)
        expect(policy).not_to be_allowed
      end
    end
  end
end
