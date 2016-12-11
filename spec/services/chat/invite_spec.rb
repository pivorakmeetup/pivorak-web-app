require 'rails_helper'

describe Chat::Invite, vcr: { record: :new_episodes } do
  let(:email) { 'new-user@mail.com' }
  subject { described_class.new(email) }

  describe '#call' do
    context 'when success' do
      it { expect(subject.call).to be_truthy }
    end

    context 'when empty email' do
      it { expect(described_class.call('')).to be_falsey }
    end

    context 'when invited second time' do
      it { expect {subject.call}.to raise_error(Chat::Client::ChatError, 'sent_recently') }
    end
  end
end
