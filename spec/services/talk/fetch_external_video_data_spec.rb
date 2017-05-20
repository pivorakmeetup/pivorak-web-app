RSpec.describe Talk::FetchExternalVideoData, vcr: { record: :new_episodes } do
  let(:talk) do
      create :talk,
        title: '"Building Component Based Rails Applications" - practice',
        video_url: 'https://www.youtube.com/watch?v=4QdOwMVMs7k'
  end

  describe '.call' do
    let!(:result) { described_class.call(talk) }

    context 'valid video_url' do
      it { expect(talk.extra['video_duration']).to    eq 2864 }
      it { expect(talk.extra['video_likes_count']).to eq 20 }
      it { expect(talk.extra['video_views_count']).to eq 458 }
    end

    context 'no video_url' do
      let(:talk) { create :talk, video_url: nil }

      it { expect(described_class.call(talk)).to eq nil }
    end

    context 'invalid video_url' do
      let(:talk) { create :talk }

      it { expect(described_class.call(talk)).to eq nil }
    end
  end

  describe '.fetch_all' do
    let(:result) { described_class.fetch_all! }

    let(:talk_2) do
      create :talk,
        title: 'Phoenix Framework for the new web by José Valim',
        video_url: 'https://www.youtube.com/watch?v=Toluc5MCQWs'
    end

    it 'call service for all talks' do
      expect(Talk::FetchExternalVideoData).to receive(:new).with(talk)
      expect(Talk::FetchExternalVideoData).to receive(:new).with(talk_2)

      result
    end
  end
end
