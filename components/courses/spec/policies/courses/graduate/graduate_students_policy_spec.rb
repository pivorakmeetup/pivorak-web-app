require 'rails_helper'

describe Courses::Season::GraduateStudentsPolicy do
  let (:season)    { create(:season, title: 'Test Season', status: :passed) }
  let!(:student)   { create(:student, season: season, status: :attending) }
  
  subject(:policy) { described_class.new(season) }

  describe '#allowed?' do
    context 'passed season' do
      it 'allows to pass policy' do
        expect(policy.allowed?).to be_truthy
      end
    end

    context 'not passed season' do
      it 'forbids to pass policy' do
        season.update_attribute(:status, :selection)
        season.reload

        expect(policy.allowed?).to be_falsey
      end
    end

    context 'there are attending students' do
      it 'allows to pass policy' do
        expect(policy.allowed?).to be_truthy
      end
    end

    context 'there are no attending students' do
      it 'forbids to pass policy' do
        student.update_attribute(:status, :enrolled)
        student.reload

        expect(policy.allowed?).to be_falsey
      end
    end
  end
end
