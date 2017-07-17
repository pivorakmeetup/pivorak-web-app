RSpec.describe 'Talks search' do

  let(:event) { create :event, title: 'Event Title' }

  let!(:talk_1) { create :talk, title: 'Talk 1', description: "infrastructure", event: event }
  let!(:talk_2) { create :talk, title: 'Talk 2', description: "service objects", event: event }

  let(:title_of_talk_1) { 'Talk 1' }
  let(:description_of_talk_2) { 'service objects' }

  before do
    visit "/talks"
  end

  context 'should have all talks with assigned speakers on the page' do
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

    it 'searches by description' do
      fill_in 'query', with: description_of_talk_2
      click_button('Search')

      expect(page).to have_content talk_2.title
      expect(page).not_to have_content talk_1.title
    end
  end
end
