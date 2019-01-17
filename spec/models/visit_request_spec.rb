RSpec.describe VisitRequest do
  describe '#checked_in?' do
    subject { build_stubbed(:visit_request) }

    its(:checked_in?) { is_expected.to be_falsey }

    context 'when checked in' do
      subject { build_stubbed(:visit_request, :visited) }

      its(:checked_in?) { is_expected.to be_truthy }
    end
  end
end
