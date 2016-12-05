require 'rails_helper'

describe Slack::Invite, vcr: { record: :new_episodes } do
  let(:email) { 'new-user@mail.com' }
  subject { described_class.new(email: email) }

  describe '#call' do
    context 'when success' do
      it { expect(subject.call).to be_truthy }
    end

    context 'when invited second time' do
      it { expect(subject.call).to be_falsey }
    end
  end

end
