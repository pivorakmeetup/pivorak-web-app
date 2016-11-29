RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
  end
end
