# frozen_string_literal: true

xdescribe Goal, type: :model do
  let(:goal) { create(:goal, :with_donations) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount) }
    it { is_expected.to validate_presence_of(:title) }
  end
end
