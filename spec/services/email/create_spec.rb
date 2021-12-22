# frozen_string_literal: true

describe Email::Create do
  subject(:create_email) { described_class.call(params: params, recipient_ids: recipient_ids) }

  let(:recipient_ids) { [0] }

  describe '#call' do
    context 'when params are valid' do
      let(:params) { { subject: 'subject-subject', body: 'body-body' } }

      it { expect { create_email }.to change(Email, :count).by(1) }

      it 'executes Send service' do
        email = build_stubbed(:email)
        email_send_service = class_spy(Email::Send).as_stubbed_const

        allow(Email).to receive(:create).and_return(email)

        create_email

        expect(email_send_service).to have_received(:call).with(email: email, recipient_ids: recipient_ids)
      end
    end

    context 'when params are invalid' do
      let(:params) { { subject: '', body: '' } }

      it { expect { create_email }.to change(Email, :count).by(0) }
      it { expect(create_email).to be_falsey }
    end
  end
end
