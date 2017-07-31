RSpec.describe 'Admin auth' do
  let(:user) { create(:user) }

  before { assume_logged_in(user) }

  it 'redirects to home path' do
    visit '/admin'

    expect(page).to have_current_path '/'
  end
end
