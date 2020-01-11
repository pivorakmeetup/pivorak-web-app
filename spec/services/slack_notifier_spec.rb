# frozen_string_literal: true

describe SlackNotifier do
  let(:service) { described_class.new(channel: channel, message: message) }

  let(:channel) { 'dummy-channel-name' }
  let(:message) { 'foo-text' }

  describe '#call' do
    it 'sends slack notification' do
      ClimateControl.modify SLACK_WEBHOOK_URL: 'webhook-url.slack' do
        stub_const("#{described_class}::USER_NAME", 'notifier-bot-name')

        notifier = instance_double(Slack::Notifier, ping: true)
        allow(Slack::Notifier).to receive(:new).with(
          'webhook-url.slack',
          channel:  'dummy-channel-name',
          username: 'notifier-bot-name'
        ).and_return(notifier)

        service.call

        expect(notifier).to have_received(:ping).with('foo-text')
      end
    end
  end
end
