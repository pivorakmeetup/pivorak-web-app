RSpec.describe User::Squash do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:valid_params) { { squshed_user: user_a, into_user: user_b } }

  describe '.call' do
    let!(:identity)      { create :identity,      user: user_a }
    let!(:donation)      { create :donation,      user: user_a }
    let!(:talk)          { create :talk,       speaker: user_a }
    let!(:visit_request) { create :visit_request, user: user_a }

    context 'user_a has dependencies' do
      it { expect(user_a.identities.first).to     eq identity }
      it { expect(user_a.donations.first).to      eq donation }
      it { expect(user_a.talks.first).to          eq talk }
      it { expect(user_a.visit_requests.first).to eq visit_request }
    end

    context 'user_b got dependencies of user_a and user_a was destroyed' do
      before { described_class.call(valid_params) }

      it { expect(user_b.identities.first).to     eq identity }
      it { expect(user_b.donations.first).to      eq donation }
      it { expect(user_b.talks.first).to          eq talk }
      it { expect(user_b.visit_requests.first).to eq visit_request }
      it { expect(user_a).to_not be_persisted }
    end
  end

  describe '#schema' do
    let(:wrong_params)   { { user_a: User.new, user_b: Class.new } }
    let(:invalid_params) { { squshed_user: Class.new, into_user: Class.new } }
    let(:stupid_params)  { { squshed_user: user_a, into_user: user_a } }

    it { expect(described_class.call(valid_params)).to_not be_nil }
    it { expect(described_class.call(wrong_params)).to be_nil }
    it { expect(described_class.call(invalid_params)).to be_nil }
    it { expect(described_class.call(stupid_params)).to be_nil }
  end

  describe '#dependencies' do
    let(:expected_dependencies) {
      {
        has_many: {
          Identity     => :user_id,
          Donation     => :user_id,
          Talk         => :speaker_id,
          VisitRequest => :user_id
        }
      }
    }

    it { expect(described_class.new.dependencies).to eq expected_dependencies }
  end
end
