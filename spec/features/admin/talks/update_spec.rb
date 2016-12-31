RSpec.describe 'Talks UPDATE' do
  let!(:talk)          { create(:talk, title: 'Test Talk', tag_list: 'old tags') }
  let(:test_edit_path) { '/admin/talks/test-talk/edit' }

  before do
    assume_admin_logged_in
    visit test_edit_path
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Update Talk'

      expect_an_error talk_title:  :blank
    end
  end

  context 'valid input' do
    it 'update talk' do
      fill_in 'Title',  with: 'Super New Talk'
      click_button 'Update Talk'

      expect(page).to have_current_path '/talks/test-talk'
    end
  end

  context 'with tags' do
    it 'update tags' do
      fill_in 'Title',    with: 'Talks with Tags'
      fill_in 'Tag list', with: 'new, tags'
      click_button 'Update Talk'
      visit '/admin/talks'

      expect(page).to have_content 'tags, new'
    end
  end
end
