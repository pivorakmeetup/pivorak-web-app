describe PlannedEventPresenter, type: :presenter do
  let(:presenter) { described_class.new(event, view) }

  describe '#upcoming_date' do
    context 'planned' do
      let(:started_at) { Date.new(2019,1,2) }
      let(:event)      { create :event, :planned, started_at: started_at }
      let(:expected)   { started_at.strftime("#{started_at.day.ordinalize} of %B") }

      it 'returns decorated date' do
        expect(presenter.upcoming_date).to eq expected
      end
    end

    context 'soon' do
      shared_examples 'soon' do
        it 'returns `soon` string' do
          expect(presenter.upcoming_date).to eq 'soon'
        end
      end

      context 'with event' do
        let(:event) { create :event }

        it_behaves_like 'soon'
      end

      context 'without event' do
        let(:event) { nil }

        it_behaves_like 'soon'
      end
    end
  end
end