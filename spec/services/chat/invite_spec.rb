# frozen_string_literal: true

require 'rails_helper'

describe Chat::Invite do
  subject { described_class.new(email) }

  let(:email) { 'new-user@mail.com' }
  let(:mocked_client) { instance_spy(Chat::Client) }

  describe '#call' do
    context 'when success' do
      it 'invites using client', :aggregate_failures do
        chat_client = class_spy(Chat::Client).as_stubbed_const
        allow(chat_client).to receive(:new)
          .with(url: Chat::Invite::INVITE_URL, params: { resend: true, email: email })
          .and_return(mocked_client)

        expect(subject.call).to be_truthy
        expect(mocked_client).to have_received(:call)
      end
    end

    context 'when empty email' do
      it { expect(described_class.call('')).to be_falsey }
    end
  end
end
