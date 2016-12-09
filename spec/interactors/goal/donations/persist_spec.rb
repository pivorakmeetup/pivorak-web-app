RSpec.describe Goal::Donations::Persist do
  subject(:context) { described_class.call(params) }

  let(:amount)      { Faker::Number.decimal(3, 2) }
  let(:goal)        { create(:goal) }
  let(:user)        { create(:user) }

  describe '.call' do
    context "when user isn't anonymous" do
      let(:params) {{ amount: amount, user: user, goal: goal }}

      it { is_expected.to be_a_success }

      it 'creates a donation that references user & goal' do
        expect(context.donation).to be_present
        expect(context.donation.user).to eq user
        expect(context.donation.amount.to_f).to eq amount.to_f
        expect(context.donation.goal).to eq goal
      end
    end
    context 'when user is anonymous' do
      let(:params) {{ goal: goal, amount: amount }}

      it { is_expected.to be_a_success }

      it 'creates an anonymous donation that references goal' do
        expect(context.donation).to be_present
        expect(context.donation.user).to eq nil
        expect(context.donation.amount.to_f).to eq amount.to_f
        expect(context.donation.goal).to eq goal
      end
    end
  end
end
