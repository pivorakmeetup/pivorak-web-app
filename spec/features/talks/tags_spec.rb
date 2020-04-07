# frozen_string_literal: true

describe 'Talks tags' do
  let(:event) { create :event }
  let!(:talk_about_ruby)  { create :talk, title: 'Ruby Way', tag_list: 'ruby', event: event }
  let!(:talk_about_js)    { create :talk, title: 'JS Way',   tag_list: 'javascript', event: event }
  let!(:talk_about_rails) { create :talk, title: 'Rails Way', tag_list: 'ruby, rails', event: event }

  before { visit "/talks?tag=#{tag}" }

  context 'when ruby tag' do
    let(:tag) { 'ruby' }

    it 'filter by ruby tags' do
      expect(page).to     have_content 'Ruby Way'
      expect(page).to     have_content 'Rails Way'
      expect(page).not_to have_content 'JS Way'
    end
  end

  context 'when rails tag' do
    let(:tag) { 'rails' }

    it 'filter by rails tags' do
      expect(page).to     have_content 'Rails Way'
      expect(page).not_to have_content 'Ruby Way'
      expect(page).not_to have_content 'JS Way'
    end
  end

  context 'when javascript tag' do
    let(:tag) { 'javascript' }

    it 'filter by javascript tags' do
      expect(page).to     have_content 'JS Way'
      expect(page).not_to have_content 'Ruby Way'
      expect(page).not_to have_content 'Rails Way'
    end
  end
end
