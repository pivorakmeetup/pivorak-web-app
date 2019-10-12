# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
    it { is_expected.to have_many(:donations).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value('aZ').for(:first_name) }
    it { is_expected.to allow_value('aZ').for(:last_name) }
    it { is_expected.not_to allow_value('1').for(:first_name) }
    it { is_expected.not_to allow_value('1').for(:last_name) }
    it { is_expected.not_to allow_value('Я').for(:first_name) }
    it { is_expected.not_to allow_value('Я').for(:last_name) }

    describe 'error message' do
      let(:user) { build(:user, first_name: 'Я', last_name: 'Я', email: 'denys+1@lol.com') }

      before { user.valid? }

      it { expect(user.errors[:first_name].first).to eq I18n.t 'errors.only_latin_letters' }
      it { expect(user.errors[:last_name].first).to eq I18n.t 'errors.only_latin_letters' }
      it { expect(user.errors[:email].first).to eq 'is invalid' }

      context 'when email has no `.com` or other domain' do
        let(:user) { build(:user, email: 'abc@gmail.') }

        before { user.valid? }

        it { expect(user.errors[:email].first).to eq 'is invalid' }
      end
    end
  end
end
