RSpec.describe 'Donate Process' do
  let(:donation_button) { "input[src='//static.liqpay.com/buttons/d1en.radius.png']" }

  before do
    visit root_path
  end

  it { page.should have_selector(donation_button) }
end
