# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::GraduateStudentsPolicy do
  subject(:policy) { described_class.new(season) }

  let(:season) { create(:season, title: 'Test Season', status: :passed) }
  let!(:student) { create(:student, season: season, status: :attending) }

  describe '#allowed?' do
    context 'passed season' do
      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end

    context 'not passed season' do
      it 'forbids to pass policy' do
        season.update_attribute(:status, :selection)
        season.reload

        expect(policy).not_to be_allowed
      end
    end

    context 'there are attending students' do
      it 'allows to pass policy' do
        expect(policy).to be_allowed
      end
    end

    context 'there are no attending students' do
      it 'forbids to pass policy' do
        student.update_attribute(:status, :enrolled)
        student.reload

        expect(policy).not_to be_allowed
      end
    end
  end
end
