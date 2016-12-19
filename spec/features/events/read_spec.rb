RSpec.describe 'Events READ' do
  let(:event) { create(:event) }

  before do
    visit "/events/#{event.id}"
  end

  it { expect(page).to have_content event.title }

end
