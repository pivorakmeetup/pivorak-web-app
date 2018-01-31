RSpec.describe Event do
  let!(:event) { build(:event) }

  describe 'validations' do
    it { expect(event).to be_valid }
    it { is_expected.to validate_presence_of(:title) }

    describe 'LimitsValidator' do
      let(:event) { build(:event, limit_total: 10, limit_verified: 15) }

      before { event.valid? }

      it { expect(event).to have(1).errors_on(:limit_verified) }
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
end
