# frozen_string_literal: true

RSpec.describe Goal, type: :model do
  let(:goal) { create(:goal, :with_donations) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount) }
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:donations).dependent(:destroy) }
  end

  describe '#current_sum' do
    it "returns total of goal's dontations" do
      expect(goal.donations_total).to eq goal.donations.sum(:amount)
    end
  end

  describe '#achieved?' do
    it "returns true if goal's been achieved" do
      goal.amount = goal.donations_total - 1
      expect(goal.achieved?).to eq true
    end

    it "returns false if goal has'nt been achieved" do
      goal.amount = goal.donations_total + 1
      expect(goal.achieved?).to eq false
    end
  end
end
