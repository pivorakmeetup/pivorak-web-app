# frozen_string_literal: true

RSpec.describe Event::SlotsPolicy do
  let(:event) { build(:event, limit_total: 10, limit_verified: 7) }
  let(:policy) { described_class.new(event) }
  let(:approved_visitor) { instance_double('User') }

  describe '#free_verified_slots?' do
    context 'with free slots' do
      before { allow(policy).to receive(:approved_visitors).and_return([approved_visitor] * 4) }

      it { expect(policy.free_verified_slots?).to be true }
    end

    context 'without free slots' do
      before { allow(policy).to receive(:approved_visitors).and_return([approved_visitor] * 12) }

      it { expect(policy.free_verified_slots?).to be false }
    end
  end

  describe '#free_newbies_slots?' do
    before { allow(event).to receive(:limit_newbies).and_return(5) }

    context 'with free newbies slots' do
      before { allow(policy).to receive(:approved_visitors).and_return([approved_visitor] * 3) }

      it { expect(policy.free_newbies_slots?).to be true }
    end

    context 'without free newbies slots' do
      before { allow(policy).to receive(:approved_visitors).and_return([approved_visitor] * 7) }

      it { expect(policy.free_newbies_slots?).to be false }
    end
  end
end
