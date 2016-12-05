RSpec.describe Talk do
  describe 'relations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:speaker) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
