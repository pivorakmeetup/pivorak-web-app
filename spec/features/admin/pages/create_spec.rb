# frozen_string_literal: true

RSpec.describe 'Pages CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/pages/new'
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Title',  with: ''
      fill_in 'Url', with: ''
      fill_in 'Body', with: ''
      click_button 'Create Page'

      expect_an_error page_title: :blank
      expect_an_error page_url:   :blank
      expect_an_error page_body:  :blank
      expect(page).not_to have_link 'Preview'
    end
  end

  context 'valid input' do
    it 'create new page' do
      fill_in 'Title', with: 'About Us'
      fill_in 'Url',  with: 'about-us'
      fill_in 'Body', with: 'Something about us'
      click_button 'Create Page'

      expect(page).to have_current_path "/admin/pages/#{Page.last.id}/edit"
      expect_not_an_error page_title: :blank
      expect_not_an_error page_url:   :blank
      expect_not_an_error page_body:  :blank
    end
  end
end
