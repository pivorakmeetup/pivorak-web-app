RSpec.describe Identity do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end
end
