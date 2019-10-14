# frozen_string_literal: true

RSpec.describe Talk::FetchExternalVideoData do
  let(:talk) do
    create :talk,
           title:     '"Building Component Based Rails Applications" - practice',
           video_url: 'https://www.youtube.com/watch?v=4QdOwMVMs7k'
  end

  describe '.call' do
    context 'valid video_url' do
      let(:request_params) { { id: '4QdOwMVMs7k' } }
      let(:response_mock) do
        instance_double(Yt::Video,
                        duration:   2864,
                        like_count: 20,
                        view_count: 458)
      end

      before { expect(Yt::Video).to receive(:new).with(request_params).and_return(response_mock) }

      it 'updates talk with fetched video attributes' do
        described_class.call(talk)

        expect(talk.extra['video_duration']).to    eq 2864
        expect(talk.extra['video_likes_count']).to eq 20
        expect(talk.extra['video_views_count']).to eq 458
      end
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
    let(:talk_2) do
      create :talk,
             title:     'Phoenix Framework for the new web by José Valim',
             video_url: 'https://www.youtube.com/watch?v=Toluc5MCQWs'
    end

    it 'calls service for all talks' do
      expect(Talk::FetchExternalVideoData).to receive(:new).with(talk)
      expect(Talk::FetchExternalVideoData).to receive(:new).with(talk_2)

      described_class.fetch_all!
    end
  end
end
