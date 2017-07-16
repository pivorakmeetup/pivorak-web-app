RSpec.describe 'Talks search' do
  let(:speaker_1) { create :user, first_name: 'Yukihiro', last_name: 'Matsumoto', verified: true }
  let(:speaker_2) { create :user, first_name: 'David', last_name: 'Black', verified: true }
  let(:speaker_3) { create :user, first_name: 'Sandy', last_name: 'Metz', verified: true }

  let(:event) { create :event, title: 'Event Title' }

  let!(:talk_1) { create :talk, title: 'Talk 1', speaker: speaker_1, event: event, tag_list: 'ruby'}
  let!(:talk_2) { create :talk, title: 'Talk 2', speaker: speaker_2, event: event, tag_list: 'ruby, rails' }
  let!(:talk_3) { create :talk, title: 'Talk 3', speaker: speaker_3, event: event, tag_list: 'metaprogramming' }

  let(:title_of_talk_1) { 'Talk 1' }
  let(:speaker_name_of_talk_3) { 'Sandy Metz' }
  let(:tag_of_talk_1_and_talk_2) { 'ruby' }

  before do
    visit "/talks"
  end

  context 'should have all talks with assigned speakers on the page' do
    it { expect(page).to have_content talk_1.title }
    it { expect(page).to have_content talk_2.title }
    it { expect(page).to have_content talk_3.title }
  end

  context 'should search by talk attributes' do
    it 'searches by title' do
      fill_in 'query', with: title_of_talk_1
      click_button('Search')

      expect(page).to have_content talk_1.title
      expect(page).not_to have_content talk_2.title
      expect(page).not_to have_content talk_3.title
    end

    it 'searches by speaker name' do
      fill_in 'query', with: speaker_name_of_talk_3
      click_button('Search')

      expect(page).to have_content talk_3.title
      expect(page).not_to have_content talk_2.title
      expect(page).not_to have_content talk_1.title
    end

    it 'searches by tags' do
      fill_in 'query', with: tag_of_talk_1_and_talk_2
      click_button('Search')

      expect(page).to have_content talk_1.title
      expect(page).to have_content talk_2.title
      expect(page).not_to have_content talk_3.title
    end
  end
end
