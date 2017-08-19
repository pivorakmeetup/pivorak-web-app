require 'rails_helper'

describe Courses::Student::DropPolicy do
  let!(:student)   { create(:student, status: :attending) }
  let(:high_total) {  5 }
  let(:low_total)  { -3 }

  describe '#allowed?' do
    context 'total is beyond drop point and status is not dropped' do
      it 'allows to pass policy' do
        policy = described_class.new(student, low_total)

        expect(policy.allowed?).to be_truthy
      end
    end

    context 'total is above drop point' do
      it 'forbids to pass policy' do
        policy = described_class.new(student, high_total)

        expect(policy.allowed?).to be_falsey
      end
    end

    context 'status is dropped' do
      it 'forbids to pass policy' do
        student.dropped!
        student.reload

        policy = described_class.new(student, low_total)

        expect(policy.allowed?).to be_falsey
      end
    end

    context 'status is graduated' do
      it 'forbids to pass policy' do
        student.graduated!
        student.reload

        policy = described_class.new(student, low_total)

        expect(policy.allowed?).to be_falsey
      end
    end
  end
end
