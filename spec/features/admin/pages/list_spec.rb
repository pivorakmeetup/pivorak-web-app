# frozen_string_literal: true

RSpec.describe 'Page LIST' do
  let!(:about_page)    { create(:page, title: 'About') }
  let!(:contacts_page) { create(:page, title: 'Contacts') }

  context 'open existing page' do
    before do
      assume_admin_logged_in
      visit '/admin/pages'
    end

    it { expect(page).to have_content(about_page.title) }
    it { expect(page).to have_content(about_page.url) }
    it { expect(page).to have_content(contacts_page.title) }
    it { expect(page).to have_content(contacts_page.url) }
  end
end
