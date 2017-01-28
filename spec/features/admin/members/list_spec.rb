RSpec.describe 'Members LIST' do
  let!(:user) { create(:user) }

  before do
    assume_admin_logged_in
    visit '/admin'
  end

  it 'has member name' do
    click_link('Members', match: :first)
    expect(page).to have_content user.full_name
  end
end
