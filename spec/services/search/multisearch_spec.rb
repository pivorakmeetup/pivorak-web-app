RSpec.describe Search::Multisearch do
  describe '.call' do
    context 'when provided without params' do
      let(:result) { described_class.call({}) }

      it 'returns no results' do
        expect(result.length).to eq 0
      end
    end

    context 'when provided with params' do
      let(:string) { 'example' }

      let!(:user)  { create(:user, first_name: string) }
      let!(:event) { create(:event, title: string) }
      let!(:talk)  { create(:talk, title: string) }

      let(:result) { described_class.call(query: string) }

      context 'without default formatter' do
        context 'when there are matches' do
          let(:result) { described_class.call(query: string) }

          it 'returns PgSearch collection' do
            expect(result).to be_an_instance_of PgSearch::Document::ActiveRecord_Relation
          end

          it 'returns correct amount of results' do
            expect(result.length).to eq 3
          end
        end

        context 'when there are no matches' do
          let(:result) { described_class.call(query: string.reverse) }

          it 'returns no results' do
            expect(result.length).to eq 0
          end
        end
      end
      context 'with default formatter' do
        context 'when there are matches' do
          let(:result) { described_class.call(query: string, formatter: Search::Formatters::Default) }

          it 'returns a hash' do
            expect(result).to be_an_instance_of Hash
          end

          it 'returns a correct amount of results' do
            expect(result.keys.length).to eq 3
          end

          it 'returns valid results' do
            expect(result[user.class]).to eq [user]
            expect(result[talk.class]).to eq [talk]
            expect(result[event.class]).to eq [event]
          end
        end

        context 'when there are no matches' do
          let(:result) { described_class.call(query: string.reverse, formatter: Search::Formatters::Default) }
          it 'returns no results' do
            expect(result.keys.length).to eq 0
          end
        end
      end
    end
  end
end
