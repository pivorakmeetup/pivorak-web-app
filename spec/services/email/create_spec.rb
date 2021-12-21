# frozen_string_literal: true

require 'rails_helper'

describe Email::Create do
  subject do
    described_class.call(params: params, recipient_ids: recipient_ids)
  end

  let(:recipient_ids) { [0] }

  describe '#call' do
    context 'when params are valid' do
      let(:params) { { subject: 'subject-subject', body: 'body-body' } }

      it { expect { subject }.to change(Email, :count).by(1) }

      it 'executes Send service' do
        email = build_stubbed(:email)
        email_send_service = class_spy(Email::Send).as_stubbed_const

        allow(Email).to receive(:create).and_return(email)

        subject

        expect(email_send_service).to have_received(:call).with(email: email, recipient_ids: recipient_ids)
      end
    end

    context 'when params are invalid' do
      let(:params) { { subject: '', body: '' } }

      it { expect { subject }.to change(Email, :count).by(0) }
      it { expect(subject).to be_falsey }
    end
  end
end
