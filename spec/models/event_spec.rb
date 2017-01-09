RSpec.describe Event do
  let!(:event) { build(:event) }

  describe 'validations' do
    it { expect(event).to be_valid }
    it { is_expected.to validate_presence_of(:title) }

    describe 'LimitsValidator' do
      let(:event) { build(:event, limit_total: 10, limit_verified: 15) }

      before { event.valid? }

      it { expect(event).to have(1).errors_on(:limit_verified)}
      it { expect(event.errors[:limit_verified].first).to eq I18n.t 'errors.total_less_verified' }
    end
  end

  describe 'relations' do
    it { is_expected.to have_many(:talks) }
  end

  describe '#limit_newbies' do
    let(:event) { build(:event, limit_total: 10, limit_verified: 7) }

    it 'returns difference btwn limit_total and limit_verified' do
      expect(event.limit_newbies).to eq 3
    end
  end

  describe '#has_free_verified_slots?' do
    let!(:event) { build(:event, limit_total: 10, limit_verified: 7) }

    context 'has' do
      before { allow(event).to receive_message_chain(:approved_visitors, :count) { 4 } }

      it { expect(event.has_free_verified_slots?).to be true }
    end

    context 'not has' do
      before { allow(event).to receive_message_chain(:approved_visitors, :count) { 12 } }

      it { expect(event.has_free_verified_slots?).to be false }
    end
  end

  describe '#has_free_newbies_slots?' do
    before { allow(event).to receive(:limit_newbies) { 5 } }

    context 'has' do
      before { allow(event).to receive_message_chain(:approved_visitors, :count) { 3 } }

      it { expect(event.has_free_newbies_slots?).to be true }
    end

    context 'not has' do
      before { allow(event).to receive_message_chain(:approved_visitors, :count) { 7 } }

      it { expect(event.has_free_newbies_slots?).to be false }
    end
  end
end
