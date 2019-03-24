# frozen_string_literal: true

require 'rails_helper'

describe Email::Send do
  let(:email) { build(:email, id: 77) }
  let(:recipient_id_1) { 1 }
  let(:recipient_id_2) { 2 }
  let(:recipient_ids) { [recipient_id_1, recipient_id_2] }

  describe '#call' do
    it 'sends email to recipients' do
      mailer = double('mailer')
      expect(EmailMailer).to receive(:custom).with(email.id, recipient_id_1) { mailer }
      expect(EmailMailer).to receive(:custom).with(email.id, recipient_id_2) { mailer }
      expect(mailer).to receive(:deliver_later).twice

      described_class.call(email: email, recipient_ids: recipient_ids)
    end
  end
end
