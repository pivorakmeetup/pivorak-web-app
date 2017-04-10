RSpec.describe Authentication::User, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
    it { is_expected.to have_many(:donations).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }

    describe 'error message' do
      let(:user) { build(:authentication_user, email: 'denys+1@lol.com') }

      before { user.valid? }

      it { expect(user.errors[:email].first).to eq 'is invalid' }
    end
  end
end
