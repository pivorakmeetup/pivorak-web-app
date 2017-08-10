require 'rails_helper'

describe Courses::Season::RegisterPolicy do
  let(:season)  { create(:season) }
  let(:student) { create(:student) }
  let(:policy)  { Courses::Season::RegisterPolicy.new(season, student) }

  describe '#allowed?' do
    context "season has status registration, student is not registered yet" do
      it 'allows to pass policy' do
        allow(policy).to receive(:season_has_status_registration?).and_return(true)
        allow(policy).to receive(:student_enrolled?).and_return(false)

        expect(policy).to be_allowed
      end
    end
  end

  describe 'not allowed?' do
    context "season doesn't have registration status" do
      it "doesn't allow to pass policy" do
        allow(policy).to receive(:season_has_status_registration?).and_return(false)
        allow(policy).to receive(:student_enrolled?).and_return(false)

        expect(policy).not_to be_allowed
      end
    end

    context "student is registered already" do
      it "doesn't allow to pass policy" do
        allow(policy).to receive(:season_has_status_registration?).and_return(true)
        allow(policy).to receive(:student_enrolled?).and_return(true)

        expect(policy).not_to be_allowed
      end
    end

    context "student has test_task_done status" do
      it "doesn't allow to pass policy" do
        allow(policy).to receive(:season_has_status_registration?).and_return(true)
        allow(policy).to receive(:student_test_task_done?).and_return(true)

        expect(policy).not_to be_allowed
      end
    end
  end
end
