RSpec.describe User::Squash do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:valid_params) { { squashed_user: user_a, into_user: user_b } }

  describe '.call' do
    context 'user_a was destroyed' do
      before { described_class.call(valid_params) }

      it { expect(user_a).to_not be_persisted }
    end
  end

  describe '#schema' do
    let(:wrong_params)   { { user_a: User.new, user_b: Class.new } }
    let(:invalid_params) { { squashed_user: Class.new, into_user: Class.new } }
    let(:stupid_params)  { { squashed_user: user_a, into_user: user_a } }

    it { expect(described_class.call(valid_params)).to_not be_nil }
    it { expect(described_class.call(wrong_params)).to be_nil }
    it { expect(described_class.call(invalid_params)).to be_nil }
    it { expect(described_class.call(stupid_params)).to be_nil }
  end

  describe '#dependencies' do
    let(:expected_dependencies) {
      {
        has_many: {
          Identity     => { foreign_key: :user_id },
          Donation     => { foreign_key: :user_id },
          Talk         => { foreign_key: :speaker_id },
          VisitRequest => { foreign_key: :user_id, squash: true, conditions: %i[event_id] }
        }
      }
    }

    it { expect(described_class.new.dependencies).to eq expected_dependencies }
  end
end
