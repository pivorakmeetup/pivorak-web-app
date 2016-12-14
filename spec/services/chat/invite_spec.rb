require 'rails_helper'

describe Chat::Invite do
  let(:email) { 'new-user@mail.com' }
  let(:mocked_client) { double('Chat::Client') }
  subject { described_class.new(email) }

  describe '#call' do
    context 'when success' do
      before do
        expect(Chat::Client).to receive(:new).with({:url=> Chat::Invite::INVITE_URL, :params=>{:resend=>true, :email=> email}}) { mocked_client }
        expect(mocked_client).to receive(:call) { true }
      end
      it { expect(subject.call).to be_truthy }
    end

    context 'when empty email' do
      it { expect(described_class.call('')).to be_falsey }
    end
  end
end
