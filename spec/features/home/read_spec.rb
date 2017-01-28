RSpec.describe 'Home READ' do
  before do
    assume_logged_in
    visit root_path
  end

  it { expect(page).to have_link 'Events' }
  it { expect(page).to have_link 'Donate' }
  # TODO VS -> Fill with other links
end
