RSpec.describe 'Events LIST' do
  let!(:event) { create(:event) }

  before do
    visit "/events"
  end

  it { expect(page).to have_content event.title }
end
