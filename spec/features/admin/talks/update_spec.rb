RSpec.describe 'Talks UPDATE' do
  let!(:talk)          { create(:talk, title: 'Test Talk') }
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
    it 'create new talk' do
      fill_in 'Title',  with: 'Super New Talk'
      click_button 'Update Talk'

      expect(page).to have_current_path '/talks/test-talk'
    end
  end
end
