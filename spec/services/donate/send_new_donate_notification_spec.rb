# frozen_string_literal: true

describe Donate::SendNewDonateNotification do
  let(:call) { described_class.call(amount: amount, currency: 'UAH') }
  let(:amount) { 5 }

  describe '#call' do
    it 'sends slack message with correct params' do
      ClimateControl.modify SLACK_NEW_DONATION_CHANNEL: 'dummy-notifications-test' do
        allow(SlackNotifier).to receive(:call)

        call

        expect(SlackNotifier).to have_received(:call).with(
          channel: 'dummy-notifications-test',
          message: [
            ':pivorak: Щойно задонатили 5 UAH :tada:.',
            'Дякую :bow: тобі анонімний #pivorak-ер!'
          ].join("\n")
        )
      end
    end

    context 'when donation amount is 0' do
      let(:amount) { 0 }

      specify do
        ClimateControl.modify SLACK_NEW_DONATION_CHANNEL: 'dummy-notifications-test' do
          allow(SlackNotifier).to receive(:call)

          call

          expect(SlackNotifier).not_to have_received(:call)
        end
      end
    end
  end
end
