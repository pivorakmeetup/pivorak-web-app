# frozen_string_literal: true

RSpec.describe Goal::Donations::Setup do
  subject(:context) { described_class.call(params) }

  let(:goal)        { create(:goal) }
  let(:user)        { create(:user) }

  describe '.call' do
    context 'provided with invalid params' do
      let(:params) { {} }

      it { is_expected.to be_a_failure }

      it 'has an error message' do
        expect(context.message).to be_present
        expect(context.message).to eq I18n.t('resources.errors.not_found', resource: Goal)
      end

      it "doesn't assign user email" do
        expect(context.email).to eq nil
      end

      it "doesn't assign goal description" do
        expect(context.description).to eq nil
      end
    end

    context 'provided with valid params' do
      context "when user isn't anonymous" do
        let(:params) { { user: user, goal: goal } }

        it { is_expected.to be_a_success }

        it 'assigns user email' do
          expect(context.email).to be_present
          expect(context.email).to eq user.email
        end

        it 'assigns goal description' do
          expect(context.description).to be_present
          expect(context.description).to eq goal.title
        end
      end
      context 'when user is anonymous' do
        let(:params) { { goal: goal, user: user, anonymous: true } }

        it { is_expected.to be_a_success }

        it 'removes user from context' do
          expect(context.user).to eq nil
        end

        it "doesn't assign user email" do
          expect(context.email).to eq nil
        end

        it 'assigns goal description' do
          expect(context.description).to be_present
          expect(context.description).to eq goal.title
        end
      end
    end
  end
end
