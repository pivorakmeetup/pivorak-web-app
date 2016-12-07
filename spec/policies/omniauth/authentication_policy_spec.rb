RSpec.describe ::Omniauth::AuthenticationPolicy do
  let(:user)     { create(:user) }
  let(:identity) { create(:identity) }

  describe '#authenticated?' do
    context 'with valid params' do
      subject { described_class.new(user: user, identity: identity) }

      it 'returns true if identity has been linked to the user' do
        user.identities << identity
        expect(subject.authenticated?).to be true
      end

      it "returns falsey value if identity hasn't been linked to the user" do
        expect(subject.authenticated?).to be_falsey
      end
    end

    context 'with invalid params' do
      subject { described_class.new({}) }

      it 'returns falsey value' do
        expect(subject.authenticated?).to be_falsey
      end
    end
  end
end
