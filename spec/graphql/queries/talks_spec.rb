# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Talks query' do
  let(:result)    { Api::Schema.execute(query, context: context, variables: variables) }
  let(:user)      { build_stubbed(:user) }
  let(:context)   { { current_user: user } }
  let(:variables) { {} }

  before do
    create(:talk, title: 'diesel')
    create(:talk, title: 'shorts')
    create(:talk, title: 'z')
  end

  context 'all talks' do
    let(:query) do
      <<~GQL
        {
          talks {
            id
            title
          }
        }
      GQL
    end

    it 'returns full list of talks' do
      expect(result['data']['talks'].size).to eq 3
    end
  end

  context 'when search talks' do
    let(:query) do
      <<~GQL
        {
          talks(search: {title: "diesel"}) {
            id
            title
          }
        }
      GQL
    end

    it 'returns matched talks' do
      expect(result['data']['talks'].size).to eq 1
      expect(result['data']['talks'][0]['title']).to eq 'diesel'
    end
  end

  context 'when pagination present' do
    let(:query) do
      <<~GQL
        query Me($pagination: Pagination) {
          talks(pagination: $pagination) {
            id
            title
          }
        }
      GQL
    end

    context 'when first page' do
      let(:variables) { { pagination: { limit: 1, offset: 0 } } }

      it 'returns paginated results' do
        expect(result['data']['talks'].size).to eq 1
        expect(result['data']['talks'][0]['title']).to eq 'diesel'
      end
    end

    context 'when second page' do
      let(:variables) { { pagination: { limit: 2, offset: 1 } } }

      it 'returns paginated results' do
        expect(result['data']['talks'].size).to eq 2
        expect(result['data']['talks'][0]['title']).to eq 'shorts'
      end
    end
  end

  context 'filter talks' do
    let(:query) do
      <<~GQL
        {
          talks(filter: { tags: ["ruby"] }) {
            id
            title
          }
        }
      GQL
    end

    let!(:talk_about_ruby)  { create :talk, title: 'Ruby Way', tag_list: 'ruby' }
    let!(:talk_about_js)    { create :talk, title: 'JS Way',   tag_list: 'javascript' }
    let!(:talk_about_rails) { create :talk, title: 'Rails Way', tag_list: 'ruby, rails' }

    context 'by tags' do
      it 'returns matched talks' do
        expect(
          result['data']['talks'].map { |talk| talk['id'].to_i }
        ).to match_array [talk_about_ruby.id, talk_about_rails.id]
      end
    end
  end
end
