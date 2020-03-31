# frozen_string_literal: true

RSpec.describe ::Omniauth::AuthenticationService do
  let(:result)   { subject.authenticate }
  let(:identity) { result.identities.first }

  describe '#authenticate' do
    context 'with valid params' do
      subject      { described_class.new(params) }

      let(:params) { build(:omniauth_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.first_name).to eq params[:info][:first_name]
        expect(result.last_name).to eq params[:info][:last_name]
        expect(result.encrypted_password).to be_present
      end

      it 'links identity to the instance' do
        result
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        result
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when twitter params' do
      subject      { described_class.new(params) }

      let(:params) { build(:twitter_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.first_name).to be_present
        expect(result.last_name).to be_present
        expect(result.encrypted_password).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when facebook params' do
      subject      { described_class.new(params) }

      let(:params) { build(:facebook_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.first_name).to be_present
        expect(result.last_name).to be_present
        expect(result.encrypted_password).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when github params' do
      subject      { described_class.new(params) }

      let(:params) { build(:github_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.first_name).to be_present
        expect(result.last_name).to be_present
        expect(result.encrypted_password).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end
  end

  context 'with invalid params' do
    subject { described_class.new({}) }

    it 'returns falsey object' do
      expect(result).to be_falsey
    end
  end
end
