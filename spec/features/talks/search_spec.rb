RSpec.describe 'Talks search' do
  let(:event) { create :event, title: 'Event Title' }

  let(:title_of_talk_1) { 'Talk 1' }
  let(:title_of_talk_2) { 'Talk 2' }
  let(:unmatched_title) { 'Something which is not present in db' }

  let(:description_of_talk_1) { 'infrastructure' }
  let(:description_of_talk_2) { 'service objects' }

  let(:tags_of_talk_1) { 'rails' }
  let(:tags_of_talk_2) { 'rspec' }

  let(:speaker_first_name) { 'John' }
  let(:speaker_last_name)  { 'Doe' }

  let(:speaker) { create :user, first_name: speaker_first_name, last_name: speaker_last_name }

  let!(:talk_1) { create :talk, title: title_of_talk_1, description: description_of_talk_1, event: event, speaker: speaker, tag_list: tags_of_talk_1 }
  let!(:talk_2) { create :talk, title: title_of_talk_2, description: description_of_talk_2, event: event, tag_list: tags_of_talk_2 }

  before do
    visit "/talks"
  end

  context 'should have all talks on the page' do
    it { expect(page).to have_content talk_1.title }
    it { expect(page).to have_content talk_2.title }
  end

  context 'should search by talk attributes' do
    it 'searches by title' do
      fill_in 'query', with: title_of_talk_1
      click_button('Search')

      expect(page).to have_content talk_1.title
      expect(page).not_to have_content talk_2.title
    end

    it "searches by speaker's full name" do
      fill_in 'query', with: "#{speaker_first_name} #{speaker_last_name}"
      click_button('Search')

      expect(page).to have_content talk_1.title
      expect(page).not_to have_content talk_2.title
    end

    it 'searches by tags' do
      fill_in 'query', with: tags_of_talk_2
      click_button('Search')

      expect(page).to have_content talk_2.title
      expect(page).not_to have_content talk_1.title
    end

    it 'searches by description' do
      fill_in 'query', with: description_of_talk_2
      click_button('Search')

      expect(page).to have_content talk_2.title
      expect(page).not_to have_content talk_1.title
    end

    it 'shows up flash message if no records have been found' do
      fill_in 'query', with: unmatched_title
      click_button('Search')

      expect(page).not_to have_content talk_2.title
      expect(page).not_to have_content talk_1.title
      expect(page).to have_content(I18n.t('search_result.not_found'))
    end
  end
end
