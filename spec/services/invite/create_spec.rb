require 'rails_helper'

describe Invite::Create do
  let(:email) { 'lol@mail.com' }
  subject { described_class.new(email: email) }

  describe '#call' do
    it 'executes Slack::Invite' do
      service = double('slack:invite', call: true)
      expect(Slack::Invite).to receive(:new).with(email: email) { service }

      expect(subject.call).to be_truthy
    end
  end
end
