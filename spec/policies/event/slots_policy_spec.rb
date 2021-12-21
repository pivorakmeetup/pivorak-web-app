# frozen_string_literal: true

RSpec.describe Event::SlotsPolicy do
  let(:event) { build(:event, limit_total: 10, limit_verified: 7) }
  let(:policy) { described_class.new(event) }

  describe '#free_verified_slots?' do
    context 'with free slots' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 4 } }

      it { expect(policy.free_verified_slots?).to be true }
    end

    context 'without free slots' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 12 } }

      it { expect(policy.free_verified_slots?).to be false }
    end
  end

  describe '#free_newbies_slots?' do
    before { allow(event).to receive(:limit_newbies).and_return(5) }

    context 'with free newbies slots' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 3 } }

      it { expect(policy.free_newbies_slots?).to be true }
    end

    context 'without free newbies slots' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 7 } }

      it { expect(policy.free_newbies_slots?).to be false }
    end
  end
end
