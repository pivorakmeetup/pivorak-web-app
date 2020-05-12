# frozen_string_literal: true

describe Donate::SendNewDonateNotification do
  let(:call) { described_class.call(amount: amount, currency: 'UAH', orderReference: order_reference, transactionStatus: transactionStatus) }
  let(:amount) { 5 }
  let(:order_reference) { 'WFP-2102129-5decabc01799e' }
  let(:transactionStatus) { 'Approved' }

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

    it 'saves donation data' do
      ClimateControl.modify SLACK_NEW_DONATION_CHANNEL: 'dummy-notifications-test' do
        allow(SlackNotifier).to receive(:call)

        expect { call }.to change(DonationData, :count).from(0).to(1)
      end
    end

    context 'when donation is duplicated' do
      it 'skips notification' do
        ClimateControl.modify SLACK_NEW_DONATION_CHANNEL: 'dummy-notifications-test' do
          allow(SlackNotifier).to receive(:call)
          DonationData.create!(order_reference: order_reference)

          expect { call }.not_to change(DonationData, :count)
          expect(SlackNotifier).not_to have_received(:call)
        end
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

    context 'when donation do not have `Approved status`' do
      let(:transactionStatus) { 'Expired' }

      it 'skips notification' do
        ClimateControl.modify SLACK_NEW_DONATION_CHANNEL: 'dummy-notifications-test' do
          allow(SlackNotifier).to receive(:call)

          expect { call }.not_to change(DonationData, :count)
          expect(SlackNotifier).not_to have_received(:call)
        end
      end
    end
  end
end
