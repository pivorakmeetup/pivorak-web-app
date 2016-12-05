RSpec.describe 'Talks CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/talks/new'
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Create Talk'

      expect_an_error talk_title:  :blank
    end
  end

  context 'valid input' do
    it 'create new talk' do
      fill_in 'Title',  with: 'Super New Talk'
      click_button 'Create Talk'

      expect(page).to have_current_path '/talks/super-new-talk'
    end
  end
end
