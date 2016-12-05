RSpec.describe Event do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:talks) }
  end
end
