# frozen_string_literal: true

require 'rails_helper'

describe Email::Send do
  let(:email) { build(:email, id: 77) }
  let(:recipient_id1) { 1 }
  let(:recipient_id2) { 2 }
  let(:recipient_ids) { [recipient_id1, recipient_id2] }

  describe '#call' do
    it 'sends email to recipients' do
      mailer = double('mailer')
      expect(EmailMailer).to receive(:custom).with(email.id, recipient_id1) { mailer }
      expect(EmailMailer).to receive(:custom).with(email.id, recipient_id2) { mailer }
      expect(mailer).to receive(:deliver_later).twice

      described_class.call(email: email, recipient_ids: recipient_ids)
    end
  end
end
