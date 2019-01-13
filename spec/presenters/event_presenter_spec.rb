describe EventPresenter, type: :presenter do
  let(:presenter) { described_class.new(event, view) }
  let(:event)     { create :event_with_talks, :live_now }

  describe 'show_talks?' do
    context 'true' do
      shared_examples 'show' do
        it { expect(presenter.show_talks?).to eq true }
      end

      describe 'full house' do
        it_should_behave_like 'show'
      end

      describe 'planned event' do
        let(:event) { create :event_with_talks, :planned }

        it_should_behave_like 'show'
      end
    end

    context 'false' do
      shared_examples 'hide' do
        it { expect(presenter.show_talks?).to eq false }
      end

      describe 'empty event' do
        let(:event) { create :event }

        it_should_behave_like 'hide'
      end

      describe 'planned event' do
        let(:event) { create :event, :planned }

        it_should_behave_like 'hide'
      end
    end
  end

  describe '#speakers_css_class' do
    it 'returns empty string for 3 talks' do
      expect(presenter.speakers_css_class).to eq EventPresenter::EMPTY_CSS_CLASS
    end

    context '4 talks' do
      let(:event) { create :event_with_talks, talks_count: 4 }

      it 'returns a css class' do
        expect(presenter.speakers_css_class).to eq EventPresenter::FOUR_SPEAKERS_CSS_CLASS
      end
    end
  end
end