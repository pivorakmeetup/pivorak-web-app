require 'rails_helper'

describe Email::Create do
  subject do
    described_class.call(params: params, recipient_ids: recipient_ids)
  end
  let(:recipient_ids) { [0] }

  describe '#call' do
    context 'when params are valid' do
      let(:params) { { subject: 'subject-subject', body: 'body-body' } }

      it { expect{ subject }.to change(Email, :count).by(1) }

      it 'executes Send service' do
        user = create(:user)
        email = create(:email)

        allow_any_instance_of(described_class).to receive(:email) { email }
        expect(Email::Send).to receive(:call).with(email: email, recipient_ids: recipient_ids)

        subject
      end
    end

    context 'when params are invalid' do
      let(:params) { { subject: '', body: '' } }
      it { expect{ subject }.to change(Email, :count).by(0) }
      it { expect(subject).to be_falsey }
    end
  end
end
