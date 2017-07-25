require 'rails_helper'

describe Courses::Season::SendHomeworkPolicy do
  let(:season)  { create(:season) }
  let(:student) { create(:student) }
  let(:policy)  { Courses::Season::SendHomeworkPolicy.new(season, student) }

  describe '#allowed?' do
    context "season has status live, student is not dropped" do
      it 'allows to pass policy' do
        allow(policy).to receive(:season_has_status_live?).and_return(true)
        allow(policy).to receive(:student_is_dropped?).and_return(false)

        expect(policy).to be_allowed
      end
    end
  end

  describe 'not allowed?' do
    context "season doesn't have live status" do
      it "doesn't allow to pass policy" do
        allow(policy).to receive(:season_has_status_live?).and_return(false)
        allow(policy).to receive(:student_is_dropped?).and_return(false)

        expect(policy).not_to be_allowed
      end
    end

    context "student is dropped" do
      it "doesn't allow to pass policy" do
        allow(policy).to receive(:season_has_status_live?).and_return(true)
        allow(policy).to receive(:student_is_dropped?).and_return(true)

        expect(policy).not_to be_allowed
      end
    end
  end
end
