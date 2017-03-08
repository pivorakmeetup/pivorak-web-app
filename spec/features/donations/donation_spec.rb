RSpec.describe 'Donate Process' do
  subject { page }

  before { visit root_path }

  it { is_expected.to have_button 'donate' }
end
