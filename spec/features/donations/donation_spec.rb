RSpec.describe 'Donate Process' do
  subject { page }

  before { visit root_path }

  it 'home page should have donate link' do
    expect(page).to have_selector('a', text: 'Donate')
  end
end
