require 'rails_helper'

describe Slack::Invite, vcr: { record: :new_episodes } do
  subject(:invite_service) { described_class.new(email: email) }

  let(:email) { 'new-user@mail.com' }
  let(:slack_client) { instance_double(Slack::Client) }

  before do
    allow(Slack::Client).to receive(:new)
      .with(url: 'https://slack.com/api/users.admin.invite', params: {email: email, resend: true})
      .and_return(slack_client)
  end

  describe '#call' do
    specify do
      allow(slack_client).to receive(:call)

      invite_service.call

      expect(slack_client).to have_received(:call)
    end
  end

end
