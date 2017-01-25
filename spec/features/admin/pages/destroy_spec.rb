RSpec.describe 'Page DESTROY' do
  let!(:test_page) { create(:page, title: 'Test Page') }

  context 'open existing page' do
    before do
      assume_admin_logged_in
      visit '/admin/pages'
      click_link 'Destroy'
    end

    it { expect(Page).to have(0).items }
  end
end
