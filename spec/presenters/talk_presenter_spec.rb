describe TalkPresenter, type: :presenter do
  let(:speaker)   { create :user }
  let(:talk)      { create :talk, speaker: speaker }
  let(:presenter) { described_class.new(talk, view) }

  describe '#speaker_cover_url' do
    it { expect(presenter.speaker_cover_url).to eq speaker.cover_url.to_s }
  end

  describe '#speaker_full_name' do
    it { expect(presenter.speaker_full_name).to eq speaker.full_name }
  end

  describe '#description' do
    it { expect(presenter.description).to eq MarkdownRenderer.call(talk.description) }
  end

  context 'no speaker' do
    let(:speaker) { nil }

    describe '#speaker_cover_url' do
      it { expect(presenter.speaker_cover_url).to eq '' }
    end

    describe '#speaker_full_name' do
      it { expect(presenter.speaker_full_name).to eq nil }
    end

    describe '#description' do
      it { expect(presenter.description).to eq MarkdownRenderer.call(talk.description) }
    end
  end
end