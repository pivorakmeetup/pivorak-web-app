RSpec.describe Event::SlotsPolicy do
  let(:event) { build(:event, limit_total: 10, limit_verified: 7) }
  let(:policy) { described_class.new(event) }

  describe '#has_free_verified_slots?' do
    context 'has' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 4 } }

      it { expect(policy.has_free_verified_slots?).to be true }
    end

    context 'not has' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 12 } }

      it { expect(policy.has_free_verified_slots?).to be false }
    end
  end

  describe '#has_free_newbies_slots?' do
    before { allow(event).to receive(:limit_newbies) { 5 } }

    context 'has' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 3 } }

      it { expect(policy.has_free_newbies_slots?).to be true }
    end

    context 'not has' do
      before { allow(policy).to receive_message_chain(:approved_visitors, :count) { 7 } }

      it { expect(policy.has_free_newbies_slots?).to be false }
    end
  end
end
