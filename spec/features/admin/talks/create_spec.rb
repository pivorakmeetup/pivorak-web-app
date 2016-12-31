RSpec.describe 'Talks CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/talks/new'
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Create Talk'

      expect_an_error talk_title:  :blank
    end
  end

  context 'valid input' do
    it 'create new talk' do
      fill_in 'Title', with: 'Super New Talk'
      click_button 'Create Talk'

      expect(page).to have_current_path '/talks/super-new-talk'
    end
  end

  context 'with tags' do
    it 'create new with tags' do
      fill_in 'Title',    with: 'Talk with Tags'
      fill_in 'Tag list', with: 'ruby rails tags'
      click_button 'Create Talk'
      visit '/admin/talks'

      expect(page).to have_content 'ruby rails tags'
    end
  end
end
