# frozen_string_literal: true

RSpec.describe 'Page UPDATE' do
  let(:test_page) { create(:page, title: 'Test page', url: 'test-page') }
  let(:test_edit_path) { "/admin/pages/#{test_page.id}/edit" }

  before do
    assume_admin_logged_in
    visit test_edit_path
  end

  context 'when invalid input' do
    it 'validates title presence' do
      fill_in 'Title', with: ''
      fill_in 'Url',   with: ''
      fill_in 'Body',  with: ''
      click_button 'Update Page'

      expect(page).to have_link 'Preview'
      expect_an_error page_title: :blank
      expect_an_error page_url:   :blank
      expect_an_error page_body:  :blank
    end
  end

  context 'when valid input' do
    it 'updates the page', :aggregate_failures do
      fill_in 'Title',  with: 'About Us'
      fill_in 'Url',    with: 'about-us'
      fill_in 'Body',   with: 'Something about us'
      click_button 'Update Page'

      expect(page).to have_current_path test_edit_path
      expect_not_an_error page_title: :blank
      expect_not_an_error page_url:   :blank
      expect_not_an_error page_body:  :blank

      click_link 'Preview'

      expect(page).to have_current_path '/about-us'
      expect(page).to have_content 'About Us'
      expect(page).to have_content 'Something about us'
    end
  end
end
