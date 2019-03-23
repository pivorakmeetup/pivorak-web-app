RSpec.describe 'Donate Process' do
  pending 'Disabled because of tax thing'
  subject { page }

  before { visit root_path }

  xit 'home page should have donate link' do
    expect(page).to have_selector('a', text: 'Donate')
  end
end
