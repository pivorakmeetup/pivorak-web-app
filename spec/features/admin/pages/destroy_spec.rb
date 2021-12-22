# frozen_string_literal: true

RSpec.describe 'Page DESTROY' do
  context 'when open existing page' do
    before do
      create(:page, title: 'Test Page')

      assume_admin_logged_in
      visit '/admin/pages'
      click_link 'Destroy'
    end

    it { expect(Page).to have(0).items }
  end
end
