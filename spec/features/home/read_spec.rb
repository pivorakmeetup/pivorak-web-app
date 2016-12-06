RSpec.describe 'Home READ' do
  before do
    assume_logged_in
    visit root_path
  end

  it { expect(page).to have_link 'Events' }
  it { expect(page).to have_link 'Talks' }
  it { expect(page).to have_link 'Goals' }
end
