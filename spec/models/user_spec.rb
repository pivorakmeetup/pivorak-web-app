RSpec.describe User, type: :model do
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
  end

  describe 'relations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
    it { is_expected.to have_many(:donations).dependent(:destroy) }
  end

  describe 'error message' do
    context 'when first name is invalid' do
      it 'sets correct error message' do
        user = User.new(first_name: 'Я')
        user.save

        expect(user.errors[:first_name]).to eq [I18n.t('errors.only_latin_letters')]
      end
    end
    context 'when first name is invalid' do
      it 'sets correct error message' do
        user = User.new(last_name: 'Я')
        user.save

        expect(user.errors[:last_name]).to eq [I18n.t('errors.only_latin_letters')]
      end
    end
  end
end
