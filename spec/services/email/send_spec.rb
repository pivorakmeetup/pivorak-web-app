# frozen_string_literal: true

require 'rails_helper'

describe Email::Send do
  let(:email) { build(:email, id: 77) }
  let(:recipient_id1) { 1 }
  let(:recipient_id2) { 2 }
  let(:recipient_ids) { [recipient_id1, recipient_id2] }

  describe '#call' do
    it 'sends email to recipients', :aggregate_failures do
      mailer = instance_spy('mail', deliver_later: 'oh')
      allow(EmailMailer).to receive(:custom).with(email.id, recipient_id1).and_return(mailer)
      allow(EmailMailer).to receive(:custom).with(email.id, recipient_id2).and_return(mailer)

      described_class.call(email: email, recipient_ids: recipient_ids)

      expect(mailer).to have_received(:deliver_later).twice
      expect(EmailMailer).to have_received(:custom).with(email.id, recipient_id1)
      expect(EmailMailer).to have_received(:custom).with(email.id, recipient_id2)
    end
  end
end
