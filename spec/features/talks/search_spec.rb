# frozen_string_literal: true

RSpec.describe 'Talks search' do
  let(:event) { create :event, title: 'Event Title' }

  let(:title_of_talk1) { 'Talk 1' }
  let(:title_of_talk2) { 'Talk 2' }
  let(:unmatched_title) { 'Something which is not present in db' }

  let(:description_of_talk1) { 'infrastructure' }
  let(:description_of_talk2) { 'service objects' }

  let!(:talk1) { create :talk, title: title_of_talk1, description: description_of_talk1, event: event }
  let!(:talk2) { create :talk, title: title_of_talk2, description: description_of_talk2, event: event }

  before do
    visit '/talks'
  end

  describe 'should have all talks on the page' do
    it { expect(page).to have_content talk1.title }
    it { expect(page).to have_content talk2.title }
  end

  describe 'should search by talk attributes' do
    it 'searches by title', :aggregate_failures do
      fill_in 'query', with: title_of_talk1
      click_button('Search')

      expect(page).to have_content talk1.title
      expect(page).not_to have_content talk2.title
    end

    it 'searches by description', :aggregate_failures do
      fill_in 'query', with: description_of_talk2
      click_button('Search')

      expect(page).to have_content talk2.title
      expect(page).not_to have_content talk1.title
    end

    it 'shows up flash message if no records have been found', :aggregate_failures do
      fill_in 'query', with: unmatched_title
      click_button('Search')

      expect(page).not_to have_content talk2.title
      expect(page).not_to have_content talk1.title
      expect(page).to have_content(I18n.t('search_result.not_found'))
    end
  end
end
