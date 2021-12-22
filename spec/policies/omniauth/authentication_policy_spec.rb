# frozen_string_literal: true

RSpec.describe ::Omniauth::AuthenticationPolicy do
  let(:user)     { create(:user) }
  let(:identity) { create(:identity) }

  describe '#authenticated?' do
    context 'with valid params' do
      let(:authentication_policy) { described_class.new(user: user, identity: identity) }

      it 'returns true if identity has been linked to the user' do
        user.identities << identity
        expect(authentication_policy.authenticated?).to be true
      end

      it "returns falsey value if identity hasn't been linked to the user" do
        expect(authentication_policy).not_to be_authenticated
      end
    end

    context 'with invalid params' do
      let(:authentication_policy) { described_class.new({}) }

      it 'returns falsey value' do
        expect(authentication_policy).not_to be_authenticated
      end
    end
  end
end
