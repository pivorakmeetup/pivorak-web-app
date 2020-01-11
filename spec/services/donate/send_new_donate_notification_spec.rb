# frozen_string_literal: true

describe Donate::SendNewDonateNotification do
  let(:call) { described_class.call('amount' => 5, 'currency' => 'UAH') }

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
  end
end
