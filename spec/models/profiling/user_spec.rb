RSpec.describe Profiling::User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value('aZ').for(:first_name) }
    it { is_expected.to allow_value('aZ').for(:last_name) }
    it { is_expected.to_not allow_value('1').for(:first_name) }
    it { is_expected.to_not allow_value('1').for(:last_name) }
    it { is_expected.to_not allow_value('Я').for(:first_name) }
    it { is_expected.to_not allow_value('Я').for(:last_name) }

    describe 'error message' do
      let(:user) { build(:profiling_user, first_name: 'Я',  last_name: 'Я') }

      before { user.valid? }

      it { expect(user.errors[:first_name].first).to eq I18n.t 'errors.only_latin_letters' }
      it { expect(user.errors[:last_name].first).to eq I18n.t 'errors.only_latin_letters' }
    end
  end
end
